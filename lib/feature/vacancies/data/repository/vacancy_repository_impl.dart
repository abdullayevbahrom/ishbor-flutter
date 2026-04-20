import 'package:dartz/dartz.dart';

import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/common/data/models/pagination_model.dart';
import 'package:top_jobs/feature/vacancies/data/data_source/vacancy_datasource.dart';
import 'package:top_jobs/feature/vacancies/data/models/new_vacancy_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_create_model.dart';

import 'package:top_jobs/feature/vacancies/data/models/vacancy_response.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../domain/repository/vacancy_repository.dart';
import '../models/vacancy_query_params.dart';

class VacancyRepositoryImpl extends VacancyRepository {
  final VacancyDataSource _vacancyDataSource;

  VacancyRepositoryImpl(VacancyDataSource vacancyDataSource)
    : _vacancyDataSource = vacancyDataSource;

  @override
  Future<Either<Failure, VacancyResponse>> generateVacancy({
    required String text,
  }) async {
    final response = await _vacancyDataSource.generateVacancy(text: text);

    return response.fold(
      (failure) {
        return Left(Failure(message: failure.message));
      },
      (response) {
        return Right(response);
      },
    );
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchVacancies({
    required QueryParams queryParams,
  }) async {
    final result = await _vacancyDataSource.fetchVacancies(
      queryParams: queryParams,
    );

    return result.fold(
      (failure) {
        return Left(Failure(message: failure.message));
      },
      (response) {
        return Right(response);
      },
    );
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchSimilarVacancies({
    required CommonQueryParams queryParams,
  }) async {
    final result = await _vacancyDataSource.fetchSimilarVacancies(
      queryParams: queryParams,
    );
    return result.fold(
      (failure) {
        return Left(Failure(message: failure.message));
      },
      (response) {
        return Right(response);
      },
    );
  }

  @override
  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyRequest vacancy,
  }) async {
    final response = await _vacancyDataSource.createVacancy(vacancy: vacancy);
    return response.fold(
      (failure) {
        return Left(Failure(message: failure.message));
      },
      (response) {
        return Right(response);
      },
    );
  }

  @override
  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _vacancyDataSource.fetchAppliedVacancies(
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
  Future<Either<Failure, VacancyPaginationResponse>> fetchUserVacancies({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _vacancyDataSource.fetchUserVacancies(
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
  Future<Either<Failure, Vacancy>> fetchVacancyById({required int id}) async {
    final response = await _vacancyDataSource.fetchVacancyById(id: id);

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
  Future<Either<Failure, List<Vacancy>>> fetchVacanciesGeo({
    required LocationFilterModel queryParams,
  }) async {
    final response = await _vacancyDataSource.fetchVacanciesGeo(
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
  Future<Either<Failure, Vacancy>> editVacancy({
    required VacancyRequest vacancy,
  }) async {
    final response = await _vacancyDataSource.editVacancy(vacancy: vacancy);
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
  Future<Either<Failure, void>> deactivateVacancyById({
    required VacancyRequest vacancy,
  }) async {
    final response = await _vacancyDataSource.deactivateVacancyById(
      vacancy: vacancy,
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
  Future<Either<Failure, void>> deleteVacancyById({
    required int vacancyId,
  }) async {
    final response = await _vacancyDataSource.deleteVacancyById(
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

  @override
  Future<Either<Failure, void>> liftUpVacancyById({
    required int vacancyId,
  }) async {
    final response = await _vacancyDataSource.liftUpVacancyById(
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

  @override
  Future<Either<Failure, void>> toggleFavorite({required int vacancyId}) async {
    final response = await _vacancyDataSource.toggleFavorite(
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

  @override
  Future<Either<Failure, PaginationResponse<NewVacancyModel>>>
  fetchNewVacancies({required QueryParams queryParams}) async {
    final result = await _vacancyDataSource.fetchNewVacancies(
      queryParams: queryParams,
    );
    return result.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
