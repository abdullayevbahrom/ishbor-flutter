import 'package:dartz/dartz.dart';

import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/profile/data/datasource/my_vacancies_datasource.dart';

import '../../domain/repository/my_vacancies_repository.dart';

class MyVacanciesRepositoryImpl implements MyVacanciesRepository {
  final MyVacanciesDataSource _myVacanciesDataSource;

  MyVacanciesRepositoryImpl(this._myVacanciesDataSource);

  @override
  Future<Either<Failure, void>> changeVacancyStatus({
    required String status,
    required int vacancyId,
  }) async {
    final response = await _myVacanciesDataSource.changeVacancyStatus(
      status: status,
      vacancyId: vacancyId,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(unit);
      },
    );
  }
}
