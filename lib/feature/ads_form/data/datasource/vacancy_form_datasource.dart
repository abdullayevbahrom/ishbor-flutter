import 'dart:async';
import 'dart:convert';
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

  @override
  Future<Either<Failure, NewChatGptResponse>> generateVacancyBody({
    required String prompt,
  }) async {
    try {
      final response = await _dio.get(
        "chatgpt-new",
        queryParameters: {"prompt": prompt},
      );
      if (response.statusCode == 200) {
        return Right(NewChatGptResponse.fromMap(response.data));
      } else {
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
  Future<Either<Failure, String>> generateVacancyDesc({
    required String prompt,
  }) async {
    try {
      final response = await _dio.get(
        'chatgpt-description-new',
        queryParameters: {'prompt': prompt},
      );

      if (response.statusCode == 200 && response.data != null) {
        return Right(response.data);
      } else {
        return Left(
          Failure(message: response.data?.toString() ?? 'Unknown error'),
        );
      }
    } on DioException catch (e) {
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
      FormData data = FormData.fromMap(vacancyParams.toJson());

      if (vacancyParams.uploadedImages.isNotEmpty) {
        for (final image in vacancyParams.uploadedImages) {
          final String fileName = image.path.split('/').last;
          final String type = image.path.split('.').last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              'uploadedImages[]',
              MultipartFile.fromBytes(
                image.readAsBytesSync(),
                filename: fileName,
                contentType: DioMediaType("image", type),
              ),
            ),
          );
        }
      }
      final response = await _dio.post(ApiConstants.vacancies, data: data);
      if (response.statusCode == 200) {
        return Right(Vacancy.fromMap(response.data));
      } else {
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
      final response = await _dio.get<ResponseBody>(
        'chatgpt-description-new',
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

        await for (final chunk in utf8.decoder.bind(response.data!.stream)) {
          yield Right(chunk);
        }
    } catch (e) {
      yield Left(Failure(message: e.toString()));
    }
  }
}
