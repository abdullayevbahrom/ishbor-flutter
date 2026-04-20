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
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        if (service.categoryIds != null)
          'categories': jsonEncode(service.categoryIds ?? []),
        'description': service.description,
        if (service.price.isNotEmpty) 'price': service.price,
        "city": service.city,
        'address': {
          if (service.addressLine != null) 'addressLine': service.addressLine,
          if (service.latitude != null) 'latitude': service.latitude,
          if (service.longitude != null) 'longitude': service.longitude,
        },
        "phoneNumber": service.phoneNumber,
        if ((service.phoneNumber1 ?? '').isNotEmpty)
          "phoneNumber1": service.phoneNumber1,
        if ((service.phoneNumber2 ?? '').isNotEmpty)
          "phoneNumber2": service.phoneNumber2,
        if ((service.phoneNumber3 ?? '').isNotEmpty)
          "phoneNumber3": service.phoneNumber3,

        if (service.negotiable) 'negotiable': service.negotiable,
      });

      if (service.uploadedImages.isNotEmpty) {
        for (File file in service.uploadedImages) {
          final String fileName = file.path.split("/").last;
          final String type = file.path.split(".").last;
          data.files.add(
            MapEntry<String, MultipartFile>(
              "uploadedImages[]",
              MultipartFile.fromBytes(
                file.readAsBytesSync(),
                filename: fileName,
                contentType: DioMediaType("image", type),
              ),
            ),
          );
        }
      }
      final response = await _dio.post(ApiConstants.services, data: data);
      if (response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required int id,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.services + '/$id');
      if (response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        queryParameters: query.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) => ServiceModel.fromMap(e)).toList(),
        );
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> editService({
    required ServiceCreateRequest service,
  }) async {
    try {
      Map<String, dynamic> data = {
        'title': service.title,
        // if (service.categoryIds != null)
        //   'categories': jsonEncode(service.categoryIds ?? []),
        'description': service.description,
        if (service.price.isNotEmpty) 'price': service.price,
        "city": service.city,
        'address': {
          if (service.addressLine != null) 'addressLine': service.addressLine,
          if (service.latitude != null) 'latitude': service.latitude,
          if (service.longitude != null) 'longitude': service.longitude,
        },
        "phoneNumber": service.phoneNumber,
        if ((service.phoneNumber1 ?? '').isNotEmpty)
          "phoneNumber1": service.phoneNumber1,
        if ((service.phoneNumber2 ?? '').isNotEmpty)
          "phoneNumber2": service.phoneNumber2,
        if ((service.phoneNumber3 ?? '').isNotEmpty)
          "phoneNumber3": service.phoneNumber3,
        if (service.negotiable) 'negotiable': service.negotiable,
      };
      final response = await _dio.patch(
        ApiConstants.updateService(service.serviceId!),
        data: data,
      );
      if (response.statusCode == 200) {
        return Right(ServiceModel.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
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
        ApiConstants.deactivateServiceById(service.serviceId!),
        data: {"status": "deactivated"},
      );
      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteServiceById({
    required int serviceId,
  }) async {
    try {
      final response = await _dio.delete(
        ApiConstants.deleteServiceById(serviceId),
      );
      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> liftUpServiceById({
    required int serviceId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.liftUpServiceById(serviceId),
      );
      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> toggleServiceById({
    required int serviceId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.toggleServiceFavorite(serviceId),
      );
      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
