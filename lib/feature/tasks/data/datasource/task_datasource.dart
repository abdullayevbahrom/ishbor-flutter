import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/core/exceptions/failure.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../common/data/models/common_query_params.dart';
import '../../../common/data/models/map_filter_query.dart';
import '../../../profile/data/model/paginatated_task_requests.dart';
import '../../../vacancies/data/models/vacancy_query_params.dart';
import '../models/task_request_model.dart';

abstract class TaskDataSource {
  Future<Either<Failure, PaginatedTaskListResponse>> fetchTasks({
    required QueryParams queryParams,
  });

  Future<Either<Failure, PaginatedTaskListResponse>> fetchRecommendedTasks({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, PaginatedTaskListResponse>> fetchSimilarTasks({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, TaskModel>> createTask({
    required TaskRequestModel task,
  });

  Future<Either<Failure, List<TaskModel>>> fetchTaskGeo({
    required LocationFilterModel query,
  });

  Future<Either<Failure, TaskModel>> editTask({required TaskRequestModel task});

  Future<Either<Failure, PaginatedTaskListResponse>> fetchMyTasks({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, TaskModel>> fetchTaskById({required String id});

  Future<Either<Failure, void>> liftUpTaskById({required dynamic taskId});

  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel task,
  });

  Future<Either<Failure, void>> deleteTaskById({required dynamic taskId});

  Future<Either<Failure, void>> toggleTaskById({required dynamic taskId});

  Future<Either<Failure, void>> deleteTaskImageById({
    required dynamic taskId,
    required dynamic imageId,
  });
}

class TaskDataSourceImpl extends TaskDataSource {
  final Dio _dio;

  TaskDataSourceImpl(this._dio);

  void _log(String stage, String message) {
    if (kDebugMode) {
      debugPrint('[TASK][$stage] $message');
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
    if (raw.containsKey('data') && raw['data'] is Map) {
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

  String? _normalizeDateTime(String? value) {
    final raw = value?.trim();
    if (raw == null || raw.isEmpty) {
      return null;
    }

    final parsed = DateTime.tryParse(raw.replaceFirst(' ', 'T')) ??
        (() {
          try {
            return DateFormat('yyyy/MM/dd HH:mm').parseStrict(raw);
          } catch (_) {
            return null;
          }
        })();

    if (parsed == null) {
      return raw;
    }

    return DateFormat('yyyy-MM-dd HH:mm').format(parsed);
  }

  Future<void> _uploadTaskImages({
    required String taskId,
    required List<File> images,
  }) async {
    final data = FormData();
    for (final file in images) {
      final String fileName = file.path.split('/').last;
      final String type = file.path.split('.').last;
      data.files.add(
        MapEntry<String, MultipartFile>(
          TaskRequestModel.uploadedImagesField,
          MultipartFile.fromBytes(
            file.readAsBytesSync(),
            filename: fileName,
            contentType: DioMediaType("image", type),
          ),
        ),
      );
    }

    final response = await _dio.post(
      ApiConstants.uploadTaskImages(taskId),
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchSimilarTasks({
    required CommonQueryParams queryParams,
  }) async {
    try {
      _log(
        'similar',
        'GET ${ApiConstants.fetchSimilarTask(queryParams.id!)} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.fetchSimilarTask(queryParams.id!),
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('similar', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedTaskListResponse.fromJson(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'similar',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchTasks({
    required QueryParams queryParams,
  }) async {
    try {
      _log('list', 'GET ${ApiConstants.tasks} query=${queryParams.toMap()}');
      final response = await _dio.get(
        ApiConstants.tasks,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('list', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedTaskListResponse.fromJson(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'list',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, TaskModel>> createTask({
    required TaskRequestModel task,
  }) async {
    try {
      _log(
        'create',
        '[FIX] POST ${ApiConstants.tasks} title=${task.title} city=${task.city} categories=${task.categoryIds ?? const []} uploadedImages=${task.uploadedImages.length}',
      );
      final address = _buildAddress(
        addressLine: task.addressLine,
        latitude: task.latitude,
        longitude: task.longitude,
      );

      final data = FormData.fromMap({
        'title': task.title,
        'phone_number': task.phoneNumber,
        if ((task.phoneNumber1 ?? '').isNotEmpty)
          'phone_number1': task.phoneNumber1,
        if ((task.phoneNumber2 ?? '').isNotEmpty)
          'phone_number2': task.phoneNumber2,
        if ((task.phoneNumber3 ?? '').isNotEmpty)
          'phone_number3': task.phoneNumber3,
        if (task.categoryIds != null) 'category_ids': task.categoryIds ?? [],
        'description': task.description,
        'price': task.price,
        'payment_methods': [task.paymentMethod],
        'starts_at': _normalizeDateTime(task.startTime),
        'expires_at': _normalizeDateTime(task.exprTime),
        'city': task.city,
        if (address != null) 'address': address,
        if (address != null) 'addresses': [address],
        'negotiable': task.negotiable,
      });
      final response = await _dio.post(ApiConstants.tasks, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        _log('create', 'success status=${response.statusCode}');
        final created = TaskModel.fromJson(_unwrapMap(response.data));
        if (task.uploadedImages.isNotEmpty) {
          await _uploadTaskImages(taskId: created.id, images: task.uploadedImages);
          return await fetchTaskById(id: created.id);
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      _log(
        'applies',
        'GET ${ApiConstants.myTaskApplies} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.myTaskApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('applies', 'loaded status=${response.statusCode}');
        return Right(PaginatedTaskResponse.fromJson(_unwrapMap(response.data)));
      } else {
        _log(
          'applies',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchMyTasks({
    required CommonQueryParams queryParams,
  }) async {
    try {
      _log('mine', 'GET ${ApiConstants.myTasks} query=${queryParams.toMap()}');
      final response = await _dio.get(
        ApiConstants.myTasks,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('mine', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedTaskListResponse.fromJson(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'mine',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, TaskModel>> fetchTaskById({required String id}) async {
    try {
      _log('read', 'GET ${ApiConstants.fetchTask(id)}');
      final response = await _dio.get(ApiConstants.fetchTask(id));
      if (response.statusCode == 200) {
        _log('read', 'loaded status=${response.statusCode}');
        return Right(TaskModel.fromJson(_unwrapMap(response.data)));
      } else {
        _log(
          'read',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, List<TaskModel>>> fetchTaskGeo({
    required LocationFilterModel query,
  }) async {
    try {
      _log('geo', 'GET ${ApiConstants.tasksGeo} query=${query.toJson()}');
      final response = await _dio.get(
        ApiConstants.tasksGeo,
        queryParameters: query.toJson(),
      );
      if (response.statusCode == 200) {
        _log('geo', 'loaded status=${response.statusCode}');
        return Right(
          _unwrapList(response.data).map((e) {
            return TaskModel.fromJson(_asMap(e));
          }).toList(),
        );
      } else {
        _log(
          'geo',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, TaskModel>> editTask({
    required TaskRequestModel task,
  }) async {
    try {
      _log(
        'update',
        '[FIX] PATCH ${ApiConstants.updateTask(task.taskId!)} title=${task.title} city=${task.city} categories=${task.categoryIds ?? const []} uploadedImages=${task.uploadedImages.length}',
      );
      final address = _buildAddress(
        addressLine: task.addressLine,
        latitude: task.latitude,
        longitude: task.longitude,
      );

      final data = FormData.fromMap({
        'title': task.title,
        if (task.categoryIds != null) 'category_ids': task.categoryIds ?? [],
        'description': task.description,
        'price': task.price,
        'payment_methods': [task.paymentMethod],
        'starts_at': _normalizeDateTime(task.startTime),
        'expires_at': _normalizeDateTime(task.exprTime),
        'city': task.city,
        if (address != null) 'address': address,
        if (address != null) 'addresses': [address],
        'negotiable': task.negotiable,
      });

      final response = await _dio.patch(
        ApiConstants.updateTask(task.taskId!),
        data: data,
      );
      if (response.statusCode == 200) {
        _log('update', 'success status=${response.statusCode}');
        if (task.uploadedImages.isNotEmpty) {
          await _uploadTaskImages(
            taskId: task.taskId!.toString(),
            images: task.uploadedImages,
          );
          return await fetchTaskById(id: task.taskId!.toString());
        }
        return Right(TaskModel.fromJson(_unwrapMap(response.data)));
      } else {
        _log(
          'update',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
  Future<Either<Failure, void>> liftUpTaskById({
    required dynamic taskId,
  }) async {
    try {
      _log('lift-up', 'POST ${ApiConstants.liftUpTaskById(taskId)}');
      final response = await _dio.post(ApiConstants.liftUpTaskById(taskId));
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel task,
  }) async {
    try {
      _log(
        'status',
        'PATCH ${ApiConstants.deactivateTaskById(task.taskId!)} status=deactivated',
      );
      final response = await _dio.patch(
        ApiConstants.deactivateTaskById(task.taskId!),
        data: {"status": "deactivated"},
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskById({
    required dynamic taskId,
  }) async {
    try {
      _log('delete', 'DELETE ${ApiConstants.deleteTaskById(taskId)}');
      final response = await _dio.delete(ApiConstants.deleteTaskById(taskId));
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> toggleTaskById({
    required dynamic taskId,
  }) async {
    try {
      _log('favorite', 'POST ${ApiConstants.toggleTaskFavorite(taskId)}');
      final response = await _dio.post(ApiConstants.toggleTaskFavorite(taskId));
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> deleteTaskImageById({
    required dynamic taskId,
    required dynamic imageId,
  }) async {
    try {
      _log(
        'image-delete',
        '[FIX] DELETE ${ApiConstants.deleteTaskImage(taskId)} image=$imageId',
      );
      final response = await _dio.delete(
        ApiConstants.deleteTaskImage(taskId),
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
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedTaskListResponse>> fetchRecommendedTasks({
    required CommonQueryParams queryParams,
  }) async {
    try {
      _log(
        'recommended',
        'GET ${ApiConstants.tasksRecommended()} query=${queryParams.toMap()}',
      );
      final response = await _dio.get(
        ApiConstants.tasksRecommended(),
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        _log('recommended', 'loaded status=${response.statusCode}');
        return Right(
          PaginatedTaskListResponse.fromJson(_unwrapMap(response.data)),
        );
      } else {
        _log(
          'recommended',
          'warn status=${response.statusCode} payload=${response.data}',
        );
        return Left(Failure(message: _message(response.data)));
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
