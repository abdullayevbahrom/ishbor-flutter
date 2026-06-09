import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';

abstract class AiDataSource {
  Future<Either<Failure, Map<String, dynamic>>> analyzeAdDraft({required String prompt});
  Stream<String> streamDescription({required String prompt});
}

class AiDataSourceImpl extends AiDataSource {
  final Dio _dio;

  AiDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Map<String, dynamic>>> analyzeAdDraft({required String prompt}) async {
    try {
      final response = await _dio.get(
        ApiConstants.chatGpt,
        queryParameters: {'prompt': prompt},
      );
      if (response.statusCode == 200) {
        return Right(Map<String, dynamic>.from(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Stream<String> streamDescription({required String prompt}) async* {
    try {
      final response = await _dio.get<ResponseBody>(
        ApiConstants.chatGptDescription,
        queryParameters: {'prompt': prompt},
        options: Options(responseType: ResponseType.stream),
      );

      await for (final chunk in response.data!.stream) {
        yield String.fromCharCodes(chunk);
      }
    } catch (e) {
      debugPrint('[AI][stream][error] $e');
      yield '';
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
