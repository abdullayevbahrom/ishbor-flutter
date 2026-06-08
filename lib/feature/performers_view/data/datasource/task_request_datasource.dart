import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_task_requests.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../ads_view/data/models/task_request_params.dart';

abstract class TaskRequestDataSource {
  Future<Either<Failure, TaskRequest>> applyRequestTask({
    required TaskRequestParams params,
  });

  Future<Either<Failure, TaskRequest>> ownRequestsTask({required dynamic taskId});

  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsTask({
    required dynamic taskId,
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
        ApiConstants.applyTask(params.taskId),
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
        ApiConstants.cancelTaskRequestByCustomer(taskRequestId),
      );

      if (response.statusCode == 204) {
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
        ApiConstants.acceptTaskRequest(taskRequestId),
      );

      if (response.statusCode == 204) {
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
        ApiConstants.finishTaskRequestByCustomer(taskRequestId),
      );

      if (response.statusCode == 204) {
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
    required dynamic taskId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchListTaskRequests(taskId));
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
    required dynamic taskId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchOwnTaskRequest(taskId));

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
