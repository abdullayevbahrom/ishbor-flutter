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
  }) async {
    final response = await _requestDataSource.applyRequestTask(params: params);

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, void>> cancelTaskRequestByCustomer({
    required int taskRequestId,
  }) async {
    final response = await _requestDataSource.cancelTaskRequestByCustomer(
      taskRequestId: taskRequestId,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, void>> choosePerformer({
    required int taskRequestId,
  }) async {
    final response = await _requestDataSource.choosePerformer(
      taskRequestId: taskRequestId,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, void>> finishTaskRequestByCustomer({
    required int taskRequestId,
  }) async {
    final response = await _requestDataSource.finishTaskRequestByCustomer(
      taskRequestId: taskRequestId,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, PaginatedTaskRequestList>> listRequestsTask({
    required int taskId,
  }) async {
    final response = await _requestDataSource.listRequestsTask(taskId: taskId);
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, TaskRequest>> ownRequestsTask({
    required int taskId,
  }) async {
    final response = await _requestDataSource.ownRequestsTask(taskId: taskId);
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
