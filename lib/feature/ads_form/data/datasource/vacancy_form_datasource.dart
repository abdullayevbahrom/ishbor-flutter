import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/ads_form/data/models/request/vacancy_params.dart';
import 'package:top_jobs/feature/ads_form/data/models/response/chatgpt_response.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../models/vacancy.dart';

abstract class VacancyFormDataSource {
  Future<Either<Failure, NewChatGptResponse>> generateVacancyBody({
    required String prompt,
  });

  Future<Either<Failure, String>> generateVacancyDesc({required String prompt});

  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyParams vacancyParams,
  });

  Stream<Either<Failure, String>> generateVacancyDescription({
    required String prompt,
  });
}

class VacancyFormDataSourceImpl extends VacancyFormDataSource {
  final Dio _dio;

  VacancyFormDataSourceImpl(this._dio);

  void _log429(String label, DioException error) {
    if (error.response?.statusCode == 429) {
      debugPrint('[WARN][ai][$label] rate limit hit status=429');
    }
  }

  Future<void> _uploadVacancyImages({
    required String vacancyId,
    required List<File> images,
  }) async {
    final data = FormData();
    for (final image in images) {
      final String fileName = image.path.split('/').last;
      final String type = image.path.split('.').last;
      data.files.add(
        MapEntry<String, MultipartFile>(
          'uploadedImages',
          MultipartFile.fromBytes(
            image.readAsBytesSync(),
            filename: fileName,
            contentType: DioMediaType("image", type),
          ),
        ),
      );
    }

    final response = await _dio.post(
      ApiConstants.uploadVacancyImage(vacancyId),
      data: data,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  @override
  Future<Either<Failure, NewChatGptResponse>> generateVacancyBody({
    required String prompt,
  }) async {
    try {
      debugPrint(
        '[DEBUG][ai][body] promptLength=${prompt.trim().length} endpoint=${ApiConstants.chatGpt}',
      );
      final response = await _dio.get(
        ApiConstants.chatGpt,
        queryParameters: {'prompt': prompt},
      );
      if (response.statusCode == 200) {
        final raw = response.data;
        final payload =
            raw is Map<String, dynamic>
                ? Map<String, dynamic>.from(raw['data'] ?? raw)
                : null;
        if (payload == null) {
          return Left(
            Failure(message: response.data?.toString() ?? 'Unknown error'),
          );
        }
        final result = payload['result'];
        final mappedTitle =
            result is Map ? result['title']?.toString() ?? '' : '';
        debugPrint('[DEBUG][ai][body] mapped title=$mappedTitle');
        return Right(NewChatGptResponse.fromMap(payload));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      _log429('body', e);
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> generateVacancyDesc({
    required String prompt,
  }) async {
    try {
      debugPrint(
        '[DEBUG][ai][desc] promptLength=${prompt.trim().length} endpoint=${ApiConstants.chatGptDescription}',
      );
      final response = await _dio.get(
        ApiConstants.chatGptDescription,
        queryParameters: {'prompt': prompt},
      );

      if (response.statusCode == 200 && response.data != null) {
        final result = response.data.toString();
        debugPrint('[DEBUG][ai][desc] resultLength=${result.length}');
        return Right(result);
      } else {
        return Left(
          Failure(message: response.data?.toString() ?? 'Unknown error'),
        );
      }
    } on DioException catch (e) {
      _log429('desc', e);
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyParams vacancyParams,
  }) async {
    try {
      debugPrint(
        '[ADS-FORM][vacancy][create] POST ${ApiConstants.vacancies} categories=${vacancyParams.categories}',
      );
      final images = List<File>.from(vacancyParams.uploadedImages);
      final data = FormData.fromMap(vacancyParams.toJson());
      final response = await _dio.post(ApiConstants.vacancies, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          '[ADS-FORM][vacancy][create] success status=${response.statusCode}',
        );
        final created = Vacancy.fromMap(response.data['data'] ?? response.data);
        if (images.isNotEmpty) {
          await _uploadVacancyImages(vacancyId: created.id, images: images);
          final loaded = await _dio.get(ApiConstants.fetchVacancy(created.id));
          return Right(Vacancy.fromMap(loaded.data['data'] ?? loaded.data));
        }
        return Right(created);
      } else {
        debugPrint(
          '[ADS-FORM][vacancy][create][warn] status=${response.statusCode} payload=${response.data}',
        );
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Stream<Either<Failure, String>> generateVacancyDescription({
    required String prompt,
  }) async* {
    try {
      debugPrint(
        '[DEBUG][ai][desc-stream] promptLength=${prompt.trim().length} endpoint=${ApiConstants.chatGptDescription}',
      );
      final response = await _dio.get<ResponseBody>(
        ApiConstants.chatGptDescription,
        queryParameters: {'prompt': prompt},
        options: Options(
          responseType: ResponseType.stream,
          sendTimeout: const Duration(minutes: 3),
          receiveTimeout: const Duration(minutes: 3),
        ),
      );
      if (response.data == null) {
        yield Left(Failure(message: "Response is empty"));
      }

      var receivedLength = 0;
      await for (final chunk in utf8.decoder.bind(response.data!.stream)) {
        receivedLength += chunk.length;
        debugPrint('[DEBUG][ai][desc-stream] chunkLength=${chunk.length}');
        yield Right(chunk);
      }
      debugPrint('[DEBUG][ai][desc-stream] resultLength=$receivedLength');
    } catch (e) {
      if (e is DioException) {
        _log429('desc-stream', e);
      }
      yield Left(Failure(message: e.toString()));
    }
  }
}
