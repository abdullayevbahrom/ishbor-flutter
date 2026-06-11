import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/performers_view/data/datasource/vacancy_request_datasource.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/vacancy_requests_repository.dart';
import 'package:top_jobs/models/vacancy_request.dart';

import '../models/paginated_vacancy_requests.dart';

class VacancyRequestsRepositoryImpl extends VacancyRequestsRepository {
  final VacancyRequestDataSource _requestDataSource;

  VacancyRequestsRepositoryImpl(this._requestDataSource);

  @override
  Future<Either<Failure, VacancyRequest>> applyRequestVacancy({
    required Object vacancyId,
    required String message,
  }) {
    return _requestDataSource.applyRequestVacancy(
      vacancyId: vacancyId,
      message: message,
    );
  }

  @override
  Future<Either<Failure, VacancyRequest>> changeStatus({
    required Object requestId,
    required String status,
  }) {
    return _requestDataSource.changeStatus(
      requestId: requestId,
      status: status,
    );
  }

  @override
  Future<Either<Failure, void>> deleteRequest({required Object requestId}) {
    return _requestDataSource.deleteRequest(requestId: requestId);
  }

  @override
  Future<Either<Failure, VacancyRequest>> getRequestDetail({
    required Object requestId,
  }) {
    return _requestDataSource.getRequestDetail(requestId: requestId);
  }

  @override
  Future<Either<Failure, PaginatedVacancyRequestList>> listAllRequests({
    int? page,
    int? size,
    String? status,
  }) {
    return _requestDataSource.listAllRequests(
      page: page,
      size: size,
      status: status,
    );
  }

  @override
  Future<Either<Failure, PaginatedVacancyRequestList>> listRequestsByVacancy({
    required Object vacancyId,
    int? page,
    int? size,
    String? status,
  }) {
    return _requestDataSource.listRequestsByVacancy(
      vacancyId: vacancyId,
      page: page,
      size: size,
      status: status,
    );
  }

  @override
  Future<Either<Failure, VacancyRequest>> ownRequestsVacancy({
    required Object vacancyId,
  }) {
    return _requestDataSource.ownRequestsVacancy(vacancyId: vacancyId);
  }
}
