import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/models/map_filter_query.dart';
import 'package:top_jobs/feature/services/data/datasource/service_datasource.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/services/data/models/service_request_model.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';

class ServiceRepositoryImpl extends ServiceRepository {
  final ServiceDataSource _serviceDataSource;

  ServiceRepositoryImpl(this._serviceDataSource);

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchServices({
    required QueryParams queryParams,
  }) async {
    final response = await _serviceDataSource.fetchServices(
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
  Future<Either<Failure, PaginatedServiceResponse>> fetchSimilarServices({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _serviceDataSource.fetchSimilarServices(
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
  Future<Either<Failure, ServiceModel>> createService({
    required ServiceCreateRequest service,
  }) async {
    final response = await _serviceDataSource.createService(service: service);
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
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServiceApplies({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _serviceDataSource.fetchMyServiceApplies(
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
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServices({
    required CommonQueryParams queryParams,
  }) async {
    final response = await _serviceDataSource.fetchMyServices(
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
  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required int id,
  }) async {
    final response = await _serviceDataSource.fetchServiceById(id: id);

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
  Future<Either<Failure, List<ServiceModel>>> fetchServiceGeo({
    required LocationFilterModel query,
  }) async {
    final response = await _serviceDataSource.fetchServiceGeo(query: query);

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
  Future<Either<Failure, ServiceModel>> editService({
    required ServiceCreateRequest service,
  }) async {
    final response = await _serviceDataSource.editService(service: service);
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
  Future<Either<Failure, void>> deactivateServiceById({
    required ServiceCreateRequest service,
  }) async {
    final response = await _serviceDataSource.deactivateServiceById(
      service: service,
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
  Future<Either<Failure, void>> deleteServiceById({
    required int serviceId,
  }) async {
    final response = await _serviceDataSource.deleteServiceById(
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
  Future<Either<Failure, void>> liftUpServiceById({
    required int serviceId,
  }) async {
    final response = await _serviceDataSource.liftUpServiceById(
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
  Future<Either<Failure, void>> toggleServiceById({
    required int serviceId,
  }) async {
    final response = await _serviceDataSource.toggleServiceById(
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
}
