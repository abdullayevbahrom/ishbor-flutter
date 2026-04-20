import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';
import '../../data/models/service_request_model.dart';

abstract class ServiceRepository {
  Future<Either<Failure, PaginatedServiceResponse>> fetchServices({
    required QueryParams queryParams,
  });

  Future<Either<Failure, PaginatedServiceResponse>> fetchSimilarServices({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, ServiceModel>> createService({
    required ServiceCreateRequest service,
  });

  Future<Either<Failure, ServiceModel>> editService({
    required ServiceCreateRequest service,
  });

  Future<Either<Failure, ServiceModel>> fetchServiceById({required int id});

  Future<Either<Failure, List<ServiceModel>>> fetchServiceGeo({
    required LocationFilterModel query,
  });

  Future<Either<Failure, void>> liftUpServiceById({required int serviceId});

  Future<Either<Failure, void>> deactivateServiceById({
    required ServiceCreateRequest service,
  });

  Future<Either<Failure, void>> deleteServiceById({required int serviceId});

  Future<Either<Failure, void>> toggleServiceById({required int serviceId});

  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServices({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServiceApplies({
    required CommonQueryParams queryParams,
  });
}
