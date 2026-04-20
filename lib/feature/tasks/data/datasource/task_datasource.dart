import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  Future<Either<Failure,  PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  });

  Future<Either<Failure, TaskModel>> fetchTaskById({required int id});

  Future<Either<Failure, void>> liftUpTaskById({required int taskId});

  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel task,
  });

  Future<Either<Failure, void>> deleteTaskById({required int taskId});

  Future<Either<Failure, void>> toggleTaskById({required int taskId});
}

class TaskDataSourceImpl extends TaskDataSource {
  final Dio _dio;

  TaskDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, PaginatedTaskListResponse>> fetchSimilarTasks({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.fetchSimilarTask(queryParams.id!),
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedTaskListResponse.fromJson(response.data));
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchTasks({
    required QueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.tasks,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedTaskListResponse.fromJson(response.data));
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
  Future<Either<Failure, TaskModel>> createTask({
    required TaskRequestModel task,
  }) async {
    try {
      FormData data = FormData.fromMap({
        'title': task.title,
        "phoneNumber": task.phoneNumber,
        if ((task.phoneNumber1 ?? '').isNotEmpty)
          "phoneNumber1": task.phoneNumber1,
        if ((task.phoneNumber2 ?? '').isNotEmpty)
          "phoneNumber2": task.phoneNumber2,
        if ((task.phoneNumber3 ?? '').isNotEmpty)
          "phoneNumber3": task.phoneNumber3,

        if (task.categoryIds != null)
          'categories': jsonEncode(task.categoryIds ?? []),
        'description': task.description,
        'price': task.price,
        "paymentMethods": jsonEncode([task.paymentMethod]),
        "startsAt": task.startTime,
        "expiresAt": task.exprTime,
        "city": task.city,
        'addresses': jsonEncode([
          {
            if (task.addressLine != null) 'addressLine': task.addressLine,
            if (task.latitude != null) 'latitude': task.latitude,
            if (task.longitude != null) 'longitude': task.longitude,
          },
        ]),
        'negotiable': task.negotiable,
      });
      if (task.uploadedImages.isNotEmpty) {
        for (File file in task.uploadedImages) {
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
      final response = await _dio.post(ApiConstants.tasks, data: data);
      if (response.statusCode == 200) {
        return Right(TaskModel.fromJson(response.data));
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
  Future<Either<Failure,  PaginatedTaskResponse>> fetchMyTaskApplies({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myTaskApplies,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right( PaginatedTaskResponse.fromJson(response.data));
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
  Future<Either<Failure, PaginatedTaskListResponse>> fetchMyTasks({
    required CommonQueryParams queryParams,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.myTasks,
        queryParameters: queryParams.toMap(),
      );
      if (response.statusCode == 200) {
        return Right(PaginatedTaskListResponse.fromJson(response.data));
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
  Future<Either<Failure, TaskModel>> fetchTaskById({required int id}) async {
    try {
      final response = await _dio.get(ApiConstants.tasks + '/$id');
      if (response.statusCode == 200) {
        return Right(TaskModel.fromJson(response.data));
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
  Future<Either<Failure, List<TaskModel>>> fetchTaskGeo({
    required LocationFilterModel query,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.tasksGeo,
        queryParameters: query.toJson(),
      );
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) => TaskModel.fromJson(e)).toList(),
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
  Future<Either<Failure, TaskModel>> editTask({
    required TaskRequestModel task,
  }) async {
    try {
      Map<String, dynamic> data = ({
        'title': task.title,
        // if (task.categoryIds != null)
        //   'categories': jsonEncode(task.categoryIds ?? []),
        'description': task.description,
        'price': task.price,
        "paymentMethods": jsonEncode([task.paymentMethod]),
        "startsAt": task.startTime,
        "expiresAt": task.exprTime,
        "city": task.city,
        'addresses': jsonEncode([
          {
            if (task.addressLine != null) 'addressLine': task.addressLine,
            if (task.latitude != null) 'latitude': task.latitude,
            if (task.longitude != null) 'longitude': task.longitude,
          },
        ]),
        if (task.negotiable) 'negotiable': task.negotiable,
      });

      final response = await _dio.patch(
        ApiConstants.updateTask(task.taskId!),
        data: data,
      );
      if (response.statusCode == 200) {
        return Right(TaskModel.fromJson(response.data));
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
  Future<Either<Failure, void>> liftUpTaskById({required int taskId}) async {
    try {
      final response = await _dio.post(ApiConstants.liftUpTaskById(taskId));
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
  Future<Either<Failure, void>> deactivateTaskById({
    required TaskRequestModel task,
  }) async {
    try {
      final response = await _dio.patch(
        ApiConstants.deactivateTaskById(task.taskId!),
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
  Future<Either<Failure, void>> deleteTaskById({required int taskId}) async {
    try {
      final response = await _dio.delete(ApiConstants.deleteTaskById(taskId));
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
  Future<Either<Failure, void>> toggleTaskById({required int taskId}) async {
    try {
      final response = await _dio.post(ApiConstants.toggleTaskFavorite(taskId));
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
