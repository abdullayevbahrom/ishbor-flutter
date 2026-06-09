import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/ads_view/data/models/task_request_params.dart';
import 'package:top_jobs/feature/performers_view/data/datasource/task_request_datasource.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/task_requests_repository.dart';
import 'package:top_jobs/models/task_request.dart';

import '../models/paginated_task_requests.dart';

class TaskRequestsRepositoryImpl extends TaskRequestsRepository {
  final TaskRequestDataSource _requestDataSource;

  TaskRequestsRepositoryImpl(this._requestDataSource);

  @override
  Future<Either<Failure, TaskRequest>> applyRequestTask({
    required TaskRequestParams params,
  }) {
    return _requestDataSource.applyRequestTask(params: params);
  }

  @override
  Future<Either<Failure, void>> cancelRequestByCustomer({
    required Object requestId,
  }) {
    return _requestDataSource.cancelRequestByCustomer(requestId: requestId);
  }

  @override
  Future<Either<Failure, void>> acceptRequest({
    required Object requestId,
  }) {
    return _requestDataSource.acceptRequest(requestId: requestId);
  }

  @override
  Future<Either<Failure, void>> finishRequestByCustomer({
    required Object requestId,
  }) {
    return _requestDataSource.finishRequestByCustomer(requestId: requestId);
  }

  @override
  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsByTask({
    required Object taskId,
    int? page,
    int? size,
    String? status,
  }) {
    return _requestDataSource.listRequestsByTask(
      taskId: taskId,
      page: page,
      size: size,
      status: status,
    );
  }

  @override
  Future<Either<Failure, TaskRequest>> ownRequestsTask({
    required Object taskId,
  }) {
    return _requestDataSource.ownRequestsTask(taskId: taskId);
  }

  @override
  Future<Either<Failure, TaskRequest>> cancelRequestByPerformer({
    required Object requestId,
  }) {
    return _requestDataSource.cancelRequestByPerformer(requestId: requestId);
  }

  @override
  Future<Either<Failure, TaskRequest>> changeStatus({
    required Object requestId,
    required String status,
  }) {
    return _requestDataSource.changeStatus(requestId: requestId, status: status);
  }

  @override
  Future<Either<Failure, void>> deleteRequest({required Object requestId}) {
    return _requestDataSource.deleteRequest(requestId: requestId);
  }

  @override
  Future<Either<Failure, TaskRequest>> getRequestDetail({required Object requestId}) {
    return _requestDataSource.getRequestDetail(requestId: requestId);
  }

  @override
  Future<Either<Failure, PaginatedTaskRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  }) {
    return _requestDataSource.listAllRequests(page: page, size: size, status: status);
  }
}
