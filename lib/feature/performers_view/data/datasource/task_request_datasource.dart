import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_task_requests.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../ads_view/data/models/task_request_params.dart';

abstract class TaskRequestDataSource {
  Future<Either<Failure, TaskRequest>> applyRequestTask({
    required TaskRequestParams params,
  });

  Future<Either<Failure, TaskRequest>> ownRequestsTask({required int taskId});

  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsTask({
    required int taskId,
  });

  Future<Either<Failure, void>> choosePerformer({required int taskRequestId});

  Future<Either<Failure, void>> cancelTaskRequestByCustomer({
    required int taskRequestId,
  });

  Future<Either<Failure, void>> finishTaskRequestByCustomer({
    required int taskRequestId,
  });
}

class TaskRequestDataSourceImpl extends TaskRequestDataSource {
  final Dio _dio;

  TaskRequestDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, TaskRequest>> applyRequestTask({
    required TaskRequestParams params,
  }) async {
    try {
      final response = await _dio.post(
        '/tasks/${params.taskId}/task-requests',
        data: {"message": params.message, "price": params.price},
      );

      if (response.statusCode == 200) {
        return Right(TaskRequest.fromMap(response.data));
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
  Future<Either<Failure, void>> cancelTaskRequestByCustomer({
    required int taskRequestId,
  }) async {
    try {
      final response = await _dio.post(
        '/task-requests/${taskRequestId}/cancel-by-customer',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, void>> choosePerformer({
    required int taskRequestId,
  }) async {
    try {
      final response = await _dio.post(
        '/task-requests/${taskRequestId}/accept',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, void>> finishTaskRequestByCustomer({
    required int taskRequestId,
  }) async {
    try {
      final response = await _dio.post(
        '/task-requests/${taskRequestId}/finish-by-customer',
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsTask({
    required int taskId,
  }) async {
    try {
      final response = await _dio.get('/tasks/${taskId}/task-requests');
      if (response.statusCode == 200) {
        return Right(PaginatedTaskRequestList.fromJson(response.data));
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
  Future<Either<Failure, TaskRequest>> ownRequestsTask({
    required int taskId,
  }) async {
    try {
      final response = await _dio.get('/tasks/${taskId}/task-requests/own');

      if (response.statusCode == 200) {
        return Right(TaskRequest.fromMap(response.data['request']));
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
