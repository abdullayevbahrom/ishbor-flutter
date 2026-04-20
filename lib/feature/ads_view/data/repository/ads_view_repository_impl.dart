import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/ads_view_datasource.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_view_repository.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/models/vacancy.dart';

class AdsViewRepositoryImpl extends AdsViewRepository {
  final AdsViewDataSource _adsViewDataSource;

  AdsViewRepositoryImpl(this._adsViewDataSource);

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required int serviceId,
  }) async {
    final response = await _adsViewDataSource.fetchServiceById(
      serviceId: serviceId,
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
  Future<Either<Failure, TaskModel>> fetchTaskById({
    required int taskId,
  }) async {
    final response = await _adsViewDataSource.fetchTaskById(taskId: taskId);
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
  Future<Either<Failure, Vacancy>> fetchVacancyById({
    required int vacancyId,
  }) async {
    final response = await _adsViewDataSource.fetchVacancyById(
      vacancyId: vacancyId,
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
