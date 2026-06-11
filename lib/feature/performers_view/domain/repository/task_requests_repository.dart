import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_task_requests.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/task_request.dart';
import '../../../ads_view/data/models/task_request_params.dart';

abstract class TaskRequestsRepository {
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
