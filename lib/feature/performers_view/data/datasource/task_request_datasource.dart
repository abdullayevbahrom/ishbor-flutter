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

  Future<Either<Failure, TaskRequest>> ownRequestsTask({
    required Object taskId,
  });

  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsByTask({
    required Object taskId,
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, PaginatedTaskRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, TaskRequest>> getRequestDetail({
    required Object requestId,
  });

  Future<Either<Failure, void>> acceptRequest({required Object requestId});

  Future<Either<Failure, void>> cancelRequestByCustomer({
    required Object requestId,
  });

  Future<Either<Failure, TaskRequest>> cancelRequestByPerformer({
    required Object requestId,
  });

  Future<Either<Failure, void>> finishRequestByCustomer({
    required Object requestId,
  });

  Future<Either<Failure, TaskRequest>> changeStatus({
    required Object requestId,
    required String status,
  });

  Future<Either<Failure, void>> deleteRequest({required Object requestId});
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

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(
          TaskRequest.fromMap(response.data['data'] ?? response.data),
        );
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
  Future<Either<Failure, TaskRequest>> ownRequestsTask({
    required Object taskId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchOwnTaskRequest(taskId));
      if (response.statusCode == 200) {
        if (response.data['data'] == null) {
          return Left(Failure(message: "Not found"));
        }
        return Right(TaskRequest.fromMap(response.data['data']));
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
  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsByTask({
    required Object taskId,
    int? page,
    int? size,
    String? status,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchListTaskRequests(taskId),
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
          if (status != null) 'status': status,
        },
      );
      if (response.statusCode == 200) {
        return Right(PaginatedTaskRequestList.fromMap(response.data));
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
  Future<Either<Failure, PaginatedTaskRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.taskRequests,
        queryParameters: {
          if (page != null) 'page': page,
          if (size != null) 'size': size,
          if (status != null) 'status': status,
        },
      );
      if (response.statusCode == 200) {
        return Right(PaginatedTaskRequestList.fromMap(response.data));
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
  Future<Either<Failure, TaskRequest>> getRequestDetail({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchTaskRequest(requestId));
      if (response.statusCode == 200) {
        return Right(
          TaskRequest.fromMap(response.data['data'] ?? response.data),
        );
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
  Future<Either<Failure, void>> acceptRequest({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.acceptTaskRequest(requestId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, void>> cancelRequestByCustomer({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.cancelTaskRequestByCustomer(requestId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, TaskRequest>> cancelRequestByPerformer({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.cancelTaskRequestByPerformer(requestId),
      );
      if (response.statusCode == 200) {
        return Right(
          TaskRequest.fromMap(response.data['data'] ?? response.data),
        );
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
  Future<Either<Failure, void>> finishRequestByCustomer({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.finishTaskRequestByCustomer(requestId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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
  Future<Either<Failure, TaskRequest>> changeStatus({
    required Object requestId,
    required String status,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.changeTaskRequestStatus(requestId),
        data: {'status': status},
      );
      if (response.statusCode == 200) {
        return Right(
          TaskRequest.fromMap(response.data['data'] ?? response.data),
        );
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
  Future<Either<Failure, void>> deleteRequest({
    required Object requestId,
  }) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteTaskRequest(requestId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
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

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
