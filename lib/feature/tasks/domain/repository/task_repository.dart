import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';
import '../../../profile/data/model/paginatated_task_requests.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';
import '../../data/models/task_model.dart';
import '../../data/models/task_request_model.dart';

abstract class TaskRepository {
  Future<Either<Failure, PaginatedTaskListResponse>> fetchTasks({
    required QueryParams queryParams,
  });

  Future<Either<Failure, PaginatedTaskListResponse>> fetchSimilarTasks({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, TaskModel>> createTask({
    required TaskRequestModel taskRequest,
  });

  Future<Either<Failure, TaskModel>> editTask({required TaskRequestModel task});

  Future<Either<Failure, TaskModel>> fetchTaskById({required int id});

  Future<Either<Failure, List<TaskModel>>> fetchTaskGeo({
    required LocationFilterModel query,
  });

  Future<Either<Failure, void>> liftUpTaskById({required int taskId});

  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel taskModel,
  });

  Future<Either<Failure, void>> deleteTaskById({required int taskId});

  Future<Either<Failure, void>> toggleTaskById({required int taskId});

  Future<Either<Failure, PaginatedTaskListResponse>> fetchMyTasks({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure,  PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  });
}
