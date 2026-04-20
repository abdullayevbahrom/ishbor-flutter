import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_tasks_datasource.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_task_repository.dart';

class MyTasksRepositoryImpl implements MyTasksRepository {
  final MyTasksDataSource _dataSource;

  MyTasksRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, void>> changeStatusById({
    required int taskId,
    required String status,
  }) async {
    final response = await _dataSource.changeStatusById(
      taskId: taskId,
      status: status,
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
}
