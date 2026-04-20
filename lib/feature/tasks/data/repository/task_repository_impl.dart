import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/tasks/data/datasource/task_datasource.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/data/models/task_request_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../../profile/data/model/paginatated_task_requests.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';

class TaskRepositoryImpl extends TaskRepository {
  final TaskDataSource _taskDataSource;

  TaskRepositoryImpl(this._taskDataSource);

  @override
  Future<Either<Failure, PaginatedTaskListResponse>> fetchSimilarTasks({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _taskDataSource.fetchSimilarTasks(
      queryParams: queryParams,
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchTasks({
    required QueryParams queryParams,
  }) async {
    final response = await _taskDataSource.fetchTasks(queryParams: queryParams);
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
  Future<Either<Failure, TaskModel>> createTask({
    required TaskRequestModel taskRequest,
  }) async {
    final response = await _taskDataSource.createTask(task: taskRequest);

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
  Future<Either<Failure,  PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _taskDataSource.fetchMyTaskApplies(
      queryParams: queryParams,
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchMyTasks({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _taskDataSource.fetchMyTasks(
      queryParams: queryParams,
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
  Future<Either<Failure, TaskModel>> fetchTaskById({required int id}) async {
    final response = await _taskDataSource.fetchTaskById(id: id);

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
  Future<Either<Failure, List<TaskModel>>> fetchTaskGeo({
    required LocationFilterModel query,
  }) async {
    final response = await _taskDataSource.fetchTaskGeo(query: query);
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
  Future<Either<Failure, TaskModel>> editTask({
    required TaskRequestModel task,
  }) async {
    final response = await _taskDataSource.editTask(task: task);
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
  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel taskModel,
  }) async {
    final response = await _taskDataSource.deactivateTaskById(task: taskModel);
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
  Future<Either<Failure, void>> deleteTaskById({required int taskId}) async {
    final response = await _taskDataSource.deleteTaskById(taskId: taskId);
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
  Future<Either<Failure, void>> liftUpTaskById({required int taskId}) async {
    final response = await _taskDataSource.liftUpTaskById(taskId: taskId);
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
  Future<Either<Failure, void>> toggleTaskById({required int taskId}) async {
    final response = await _taskDataSource.toggleTaskById(taskId: taskId);
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
