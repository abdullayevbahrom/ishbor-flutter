import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_task_requests.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/task_request.dart';
import '../../../ads_view/data/models/task_request_params.dart';

abstract class TaskRequestsRepository {
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
