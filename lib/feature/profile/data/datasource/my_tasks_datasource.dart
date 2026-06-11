import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';

import '../../../../core/constants/api_const.dart';

abstract class MyTasksDataSource {
  Future<Either<Failure, Unit>> changeStatusById({
    required dynamic taskId,
    required String status,
  });
}

class MyTasksDataSourceImpl implements MyTasksDataSource {
  final Dio _dio;

  MyTasksDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, Unit>> changeStatusById({
    required dynamic taskId,
    required String status,
  }) async {
    try {
      debugPrint(
        '[TASK][status] PATCH ${ApiConstants.deactivateTaskById(taskId)} status=$status',
      );
      final response = await _dio.patch(
        ApiConstants.deactivateTaskById(taskId),
        data: {"status": status},
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint('[TASK][status] success status=${response.statusCode}');
        return Right(unit);
      } else {
        debugPrint(
          '[TASK][status][warn] status=${response.statusCode} payload=${response.data}',
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
}
