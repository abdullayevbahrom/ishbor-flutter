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
  }) {
    return _serviceDataSource.fetchServices(queryParams: queryParams);
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchSimilarServices({
    required CommonQueryParams queryParams,
  }) {
    return _serviceDataSource.fetchSimilarServices(queryParams: queryParams);
  }

  @override
  Future<Either<Failure, ServiceModel>> createService({
    required ServiceCreateRequest service,
  }) {
    return _serviceDataSource.createService(service: service);
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServiceApplies({
    required CommonQueryParams queryParams,
  }) {
    return _serviceDataSource.fetchMyServiceApplies(queryParams: queryParams);
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServices({
    required CommonQueryParams queryParams,
  }) {
    return _serviceDataSource.fetchMyServices(queryParams: queryParams);
  }

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({required Object id}) {
    return _serviceDataSource.fetchServiceById(id: id);
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> fetchServiceGeo({
    required LocationFilterModel query,
  }) {
    return _serviceDataSource.fetchServiceGeo(query: query);
  }

  @override
  Future<Either<Failure, ServiceModel>> editService({
    required ServiceCreateRequest service,
  }) {
    return _serviceDataSource.editService(service: service);
  }

  @override
  Future<Either<Failure, void>> deactivateServiceById({
    required ServiceCreateRequest service,
  }) {
    return _serviceDataSource.deactivateServiceById(service: service);
  }

  @override
  Future<Either<Failure, void>> deleteServiceById({required Object serviceId}) {
    return _serviceDataSource.deleteServiceById(serviceId: serviceId);
  }

  @override
  Future<Either<Failure, void>> liftUpServiceById({required Object serviceId}) {
    return _serviceDataSource.liftUpServiceById(serviceId: serviceId);
  }

  @override
  Future<Either<Failure, void>> toggleServiceById({required Object serviceId}) {
    return _serviceDataSource.toggleServiceById(serviceId: serviceId);
  }
}
