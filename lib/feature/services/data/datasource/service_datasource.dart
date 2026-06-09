import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';
import '../models/service_request_model.dart';

abstract class ServiceDataSource {
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

  Future<Either<Failure, ServiceModel>> fetchServiceById({required Object id});

  Future<Either<Failure, List<ServiceModel>>> fetchServiceGeo({
    required LocationFilterModel query,
  });

  Future<Either<Failure, void>> liftUpServiceById({required Object serviceId});

  Future<Either<Failure, void>> deactivateServiceById({
    required ServiceCreateRequest service,
  });

  Future<Either<Failure, void>> deleteServiceById({required Object serviceId});

  Future<Either<Failure, void>> toggleServiceById({required Object serviceId});

  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServices({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServiceApplies({
    required CommonQueryParams queryParams,
  });
}

class ServiceDataSourceImpl extends ServiceDataSource {
  final Dio _dio;

  ServiceDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchServices({
    required QueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.services,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedServiceResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchSimilarServices({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchSimilarService(queryParams.id!),
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedServiceResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> createService({
    required ServiceCreateRequest service,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'title': service.title,
        if (service.categoryIds != null) 'categories': jsonEncode(service.categoryIds ?? []),
        'description': service.description,
        'price': service.price,
        'city': service.city,
        'phone_number': service.phoneNumber,
        if (service.telegram != null) 'telegram': service.telegram,
        if (service.address != null) 'address': jsonEncode(service.address),
        'negotiable': service.negotiable,
      });

      if (service.uploadedImages != null) {
        for (var image in service.uploadedImages!) {
          data.files.add(
            MapEntry(
              'uploadedImages[]',
              await MultipartFile.fromFile(image.path),
            ),
          );
        }
      }

      final response = await _dio.post(ApiConstants.services, data: data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> editService({
    required ServiceCreateRequest service,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'title': service.title,
        if (service.categoryIds != null) 'categories': jsonEncode(service.categoryIds ?? []),
        'description': service.description,
        'price': service.price,
        'city': service.city,
        'phone_number': service.phoneNumber,
        if (service.telegram != null) 'telegram': service.telegram,
        if (service.address != null) 'address': jsonEncode(service.address),
        'negotiable': service.negotiable,
      });

      if (service.uploadedImages != null) {
        for (var image in service.uploadedImages!) {
          data.files.add(
            MapEntry(
              'uploadedImages[]',
              await MultipartFile.fromFile(image.path),
            ),
          );
        }
      }

      final response = await _dio.patch(
        ApiConstants.updateService(service.id!),
        data: data,
      );

      if (response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({required Object id}) async {
    try {
      final response = await _dio.get(ApiConstants.fetchService(id));
      if (response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<ServiceModel>>> fetchServiceGeo({
    required LocationFilterModel query,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.servicesGeo,
        queryParameters: query.toMap(),
      );
      if (response.statusCode == 200) {
        final List items = response.data['items'] ?? response.data['data'] ?? [];
        return Right(items.map((e) => ServiceModel.fromMap(e)).toList());
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> liftUpServiceById({required Object serviceId}) async {
    try {
      final response = await _dio.post(ApiConstants.liftUpServiceById(serviceId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deactivateServiceById({
    required ServiceCreateRequest service,
  }) async {
    try {
      final response = await _dio.patch(
        ApiConstants.deactivateServiceById(service.id!),
        data: {'status': service.status},
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteServiceById({required Object serviceId}) async {
    try {
      final response = await _dio.delete(ApiConstants.deleteServiceById(serviceId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> toggleServiceById({required Object serviceId}) async {
    try {
      final response = await _dio.post(ApiConstants.toggleServiceFavorite(serviceId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServices({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myServices,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedServiceResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchMyServiceApplies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myServiceApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedServiceResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
