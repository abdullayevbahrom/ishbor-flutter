import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/ads_form/data/models/request/vacancy_params.dart';
import 'package:top_jobs/feature/ads_form/data/models/response/chatgpt_response.dart';
import 'package:top_jobs/models/vacancy.dart';
import '../../../../core/exceptions/failure.dart';
import '../../domain/repository/vacancy_form_repository.dart';
import '../datasource/vacancy_form_datasource.dart';

class VacancyFormRepositoryImpl extends VacancyFormRepository {
  final VacancyFormDataSource _dataSource;

  VacancyFormRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, NewChatGptResponse>> generateVacancyBody({
    required String prompt,
  }) async {
    final response = await _dataSource.generateVacancyBody(prompt: prompt);

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
  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyParams vacancyParams,
  }) async {
    final response = await _dataSource.createVacancy(
      vacancyParams: vacancyParams,
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
  Future<Either<Failure, String>> generateVacancyDesc({
    required String prompt,
  }) async {
    final response = await _dataSource.generateVacancyDesc(prompt: prompt);
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
  Stream<Either<Failure, String>> generateVacancyDescription({
    required String prompt,
  }) {
    return _dataSource.generateVacancyDescription(prompt: prompt);
  }
}
