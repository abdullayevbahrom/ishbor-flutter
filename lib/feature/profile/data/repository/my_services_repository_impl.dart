import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/exceptions/failure.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_services_datasource.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_service_repository.dart';

class MyServicesRepositoryImpl implements MyServiceRepository {
  final MyServicesDataSource _myServicesDataSource;

  MyServicesRepositoryImpl(this._myServicesDataSource);

  @override
  Future<Either<Failure, void>> changeStatusById({
    required int serviceId,
    required String status,
  }) async {
    final response = await _myServicesDataSource.changeStatusById(
      serviceId: serviceId,
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
