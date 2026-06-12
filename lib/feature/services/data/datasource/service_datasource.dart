import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  Future<Either<Failure, void>> deleteServiceImageById({
    required Object serviceId,
    required Object imageId,
  });

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

  void _log(String stage, String message) {
    if (kDebugMode) {
      debugPrint('[SERVICE][$stage] $message');
    }
  }

  Map<String, dynamic> _asMap(dynamic source) {
    if (source is Map<String, dynamic>) {
      return Map<String, dynamic>.from(source);
    }

    if (source is Map) {
      return Map<String, dynamic>.fromEntries(
        source.entries.map(
          (entry) => MapEntry(entry.key.toString(), entry.value),
        ),
      );
    }

    return <String, dynamic>{};
  }

  Map<String, dynamic> _unwrapMap(dynamic source) {
    final raw = _asMap(source);
    if (raw['data'] is Map) {
      return _asMap(raw['data']);
    }
    return raw;
  }

  List<dynamic> _unwrapList(dynamic source) {
    if (source is List) {
      return source;
    }

    final raw = _asMap(source);
    final payload = raw['data'];
    if (payload is List) {
      return payload;
    }
    if (payload is Map && payload['items'] is List) {
      return List<dynamic>.from(payload['items'] as List);
    }
    if (raw['items'] is List) {
      return List<dynamic>.from(raw['items'] as List);
    }
    if (raw['results'] is List) {
      return List<dynamic>.from(raw['results'] as List);
    }

    return const [];
  }

  String _message(dynamic source) {
    if (source is Map) {
      final map = _asMap(source);
      final message = map['message'];
      if (message != null) {
        return message.toString();
      }
    }

    return source.toString();
  }

  Map<String, dynamic>? _buildAddress({
    required String? addressLine,
    required double? latitude,
    required double? longitude,
  }) {
    final cleanedAddressLine = addressLine?.trim();
    if ((cleanedAddressLine ?? '').isEmpty &&
        latitude == null &&
        longitude == null) {
      return null;
    }

    return {
      if ((cleanedAddressLine ?? '').isNotEmpty)
        'address_line': cleanedAddressLine,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }

  Future<void> _uploadServiceImages({
    required String serviceId,
    required List<File> images,
  }) async {
    final data = FormData();
    for (final image in images) {
      final String fileName = image.path.split('/').last;
      final String type = image.path.split('.').last;
      data.files.add(
        MapEntry<String, MultipartFile>(
          ServiceCreateRequest.uploadedImagesField,
          MultipartFile.fromBytes(
            image.readAsBytesSync(),
            filename: fileName,
            contentType: DioMediaType("image", type),
          ),
        ),
      );
    }

    final response = await _dio.post(
      ApiConstants.uploadServiceImages(serviceId),
      data: data,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  @override
  Future<Either<Failure, PaginatedServiceResponse>> fetchServices({
    required QueryParams queryParams,
  }) async {
    try {
      _log('list', 'GET ${ApiConstants.services} query=${queryParams.toMap()}');
      final response = await _dio.get(
        ApiConstants.services,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('list', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedServiceResponse.fromMap(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'list',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'similar',
        'GET ${ApiConstants.fetchSimilarService(queryParams.id!)} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.fetchSimilarService(queryParams.id!),
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('similar', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedServiceResponse.fromMap(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'similar',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'create',
        '[FIX] POST ${ApiConstants.services} title=${service.title} city=${service.city} categories=${service.categoryIds ?? const []} uploadedImages=${service.uploadedImages.length}',
      );
      final address = _buildAddress(
        addressLine: service.addressLine,
        latitude: service.latitude,
        longitude: service.longitude,
      );

      final data = FormData.fromMap({
        'title': service.title,
        if (service.categoryIds != null) 'category_ids': service.categoryIds ?? [],
        'description': service.description,
        'price': service.price,
        'city': service.city,
        'phone_number': service.phoneNumber,
        if (service.phoneNumber1 != null) 'phone_number1': service.phoneNumber1,
        if (service.phoneNumber2 != null) 'phone_number2': service.phoneNumber2,
        if (service.phoneNumber3 != null) 'phone_number3': service.phoneNumber3,
        if (address != null) 'address': address,
        'negotiable': service.negotiable,
      });

      final response = await _dio.post(ApiConstants.services, data: data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        _log('create', 'success status=${response.statusCode}');
        final created = ServiceModel.fromMap(_unwrapMap(response.data));
        if (service.uploadedImages.isNotEmpty) {
          await _uploadServiceImages(
            serviceId: created.id,
            images: service.uploadedImages,
          );
          return await fetchServiceById(id: created.id);
        }
        return Right(created);
      } else {
        _log(
          'create',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'update',
        '[FIX] PATCH ${ApiConstants.updateService(service.serviceId!)} title=${service.title} city=${service.city} categories=${service.categoryIds ?? const []} uploadedImages=${service.uploadedImages.length}',
      );
      final address = _buildAddress(
        addressLine: service.addressLine,
        latitude: service.latitude,
        longitude: service.longitude,
      );

      final data = FormData.fromMap({
        'title': service.title,
        if (service.categoryIds != null) 'category_ids': service.categoryIds ?? [],
        'description': service.description,
        'price': service.price,
        'city': service.city,
        'phone_number': service.phoneNumber,
        if (service.phoneNumber1 != null) 'phone_number1': service.phoneNumber1,
        if (service.phoneNumber2 != null) 'phone_number2': service.phoneNumber2,
        if (service.phoneNumber3 != null) 'phone_number3': service.phoneNumber3,
        if (address != null) 'address': address,
        'negotiable': service.negotiable,
      });

      final response = await _dio.patch(
        ApiConstants.updateService(service.serviceId!),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _log('update', 'success status=${response.statusCode}');
        if (service.uploadedImages.isNotEmpty) {
          await _uploadServiceImages(
            serviceId: service.serviceId!.toString(),
            images: service.uploadedImages,
          );
          return await fetchServiceById(id: service.serviceId!.toString());
        }
        return Right(ServiceModel.fromMap(_unwrapMap(response.data)));
      } else {
        _log(
          'update',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required Object id,
  }) async {
    try {
      _log('read', 'GET ${ApiConstants.fetchService(id)}');
      final response = await _dio.get(ApiConstants.fetchService(id));
      if (response.statusCode == 200) {
        _log('read', 'loaded status=${response.statusCode}');
        return Right(ServiceModel.fromMap(_unwrapMap(response.data)));
      } else {
        _log(
          'read',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log('geo', 'GET ${ApiConstants.servicesGeo} query=${query.toJson()}');
      final response = await _dio.get(
        ApiConstants.servicesGeo,
        queryParameters: query.toJson(),
      );
      if (response.statusCode == 200) {
        _log('geo', 'loaded status=${response.statusCode}');
        return Right(
          _unwrapList(
            response.data,
          ).map((e) => ServiceModel.fromMap(_asMap(e))).toList(),
        );
      } else {
        _log(
          'geo',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> liftUpServiceById({
    required Object serviceId,
  }) async {
    try {
      _log('lift-up', 'POST ${ApiConstants.liftUpServiceById(serviceId)}');
      final response = await _dio.post(
        ApiConstants.liftUpServiceById(serviceId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        _log('lift-up', 'success status=${response.statusCode}');
        return const Right(null);
      } else {
        _log(
          'lift-up',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'status',
        'PATCH ${ApiConstants.deactivateServiceById(service.serviceId!)} status=deactivated',
      );
      final response = await _dio.patch(
        ApiConstants.deactivateServiceById(service.serviceId!),
        data: {'status': 'deactivated'},
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        _log('status', 'success status=${response.statusCode}');
        return const Right(null);
      } else {
        _log(
          'status',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteServiceById({
    required Object serviceId,
  }) async {
    try {
      _log('delete', 'DELETE ${ApiConstants.deleteServiceById(serviceId)}');
      final response = await _dio.delete(
        ApiConstants.deleteServiceById(serviceId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        _log('delete', 'success status=${response.statusCode}');
        return const Right(null);
      } else {
        _log(
          'delete',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> toggleServiceById({
    required Object serviceId,
  }) async {
    try {
      _log('favorite', 'POST ${ApiConstants.toggleServiceFavorite(serviceId)}');
      final response = await _dio.post(
        ApiConstants.toggleServiceFavorite(serviceId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        _log('favorite', 'success status=${response.statusCode}');
        return const Right(null);
      } else {
        _log(
          'favorite',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteServiceImageById({
    required Object serviceId,
    required Object imageId,
  }) async {
    try {
      _log(
        'image-delete',
        '[FIX] DELETE ${ApiConstants.deleteServiceImage(serviceId)} image=$imageId',
      );
      final response = await _dio.delete(
        ApiConstants.deleteServiceImage(serviceId),
        data: {'image': imageId.toString()},
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        _log('image-delete', 'success status=${response.statusCode}');
        return const Right(null);
      } else {
        _log(
          'image-delete',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'mine',
        'GET ${ApiConstants.myServices} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.myServices,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('mine', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedServiceResponse.fromMap(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'mine',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
      _log(
        'applies',
        'GET ${ApiConstants.myServiceApplies} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.myServiceApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('applies', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedServiceResponse.fromMap(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'applies',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
