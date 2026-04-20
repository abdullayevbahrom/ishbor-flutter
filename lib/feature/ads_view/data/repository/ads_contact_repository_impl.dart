import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/exceptions/failure.dart';
import 'package:top_jobs/feature/ads_view/data/datasource/ads_contact_datasource.dart';
import 'package:top_jobs/feature/ads_view/data/models/ads_contact_model.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_contact_repository.dart';

class AdsContactRepositoryImpl implements AdsContactRepository {
  final AdsContactDataSource _adsContactDataSource;

  AdsContactRepositoryImpl(this._adsContactDataSource);

  @override
  Future<Either<Failure, AdsContactModel>> fetchServiceContact({
    required int serviceId,
  }) async {
    final response = await _adsContactDataSource.fetchServiceContact(
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
  Future<Either<Failure, AdsContactModel>> fetchTaskContact({
    required int taskId,
  }) async {
    final response = await _adsContactDataSource.fetchTaskContact(
      taskId: taskId,
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
  Future<Either<Failure, AdsContactModel>> fetchVacancyContact({
    required int vacancyId,
  }) async {
    final response = await _adsContactDataSource.fetchVacancyContact(
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
