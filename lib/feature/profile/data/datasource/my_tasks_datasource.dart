import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';

import '../../../../core/constants/api_const.dart';

abstract class MyTasksDataSource {
  Future<Either<Failure, void>> changeStatusById({
    required int taskId,
    required String status,
  });
}

class MyTasksDataSourceImpl implements MyTasksDataSource {
  final Dio _dio;

  MyTasksDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, void>> changeStatusById({
    required int taskId,
    required String status,
  }) async{
    try {
      final response = await _dio.patch(
        ApiConstants.deactivateTaskById(taskId),
        data: {"status": status},
      );
      if (response.statusCode == 200) {
        return Right(unit);
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
}
