import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/common/data/models/pagination_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/new_vacancy_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_create_model.dart';
import 'package:top_jobs/models/vacancy.dart';

import '../../../../core/network/api_http.dart';
import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';
import '../../data/models/vacancy_query_params.dart' show QueryParams;
import '../../data/models/vacancy_response.dart';

abstract class VacancyRepository {
  Future<Either<Failure, VacancyResponse>> generateVacancy({
    required String text,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchVacancies({
    required QueryParams queryParams,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchSimilarVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, Vacancy>> createVacancy({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, Vacancy>> editVacancy({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, Vacancy>> fetchVacancyById({required int id});

  Future<Either<Failure, List<Vacancy>>> fetchVacanciesGeo({
    required LocationFilterModel queryParams,
  });

  Future<Either<Failure, void>> liftUpVacancyById({required int vacancyId});

  Future<Either<Failure, void>> deactivateVacancyById({
    required VacancyRequest vacancy,
  });

  Future<Either<Failure, void>> deleteVacancyById({required int vacancyId});

  Future<Either<Failure, void>> toggleFavorite({required int vacancyId});

  Future<Either<Failure, VacancyPaginationResponse>> fetchUserVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, VacancyPaginationResponse>> fetchAppliedVacancies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, PaginationResponse<NewVacancyModel>>>
  fetchNewVacancies({required QueryParams queryParams});
}
