import 'package:dartz/dartz.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_vacancy_requests.dart';
import 'package:top_jobs/models/vacancy_request.dart';
import '../../../../core/network/api_http.dart';

abstract class VacancyRequestsRepository {
  Future<Either<Failure, VacancyRequest>> applyRequestVacancy({
    required Object vacancyId,
    required String message,
  });

  Future<Either<Failure, VacancyRequest>> ownRequestsVacancy({required Object vacancyId});

  Future<Either<Failure, PaginatedVacancyRequestList>> listRequestsByVacancy({
    required Object vacancyId,
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, PaginatedVacancyRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  });

  Future<Either<Failure, VacancyRequest>> getRequestDetail({required Object requestId});

  Future<Either<Failure, VacancyRequest>> changeStatus({
    required Object requestId,
    required String status,
  });

  Future<Either<Failure, void>> deleteRequest({required Object requestId});
}
