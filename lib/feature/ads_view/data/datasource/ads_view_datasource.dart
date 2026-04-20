import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../../models/vacancy.dart';

abstract class AdsViewDataSource {
  Future<Either<Failure, Vacancy>> fetchVacancyById({required int vacancyId});

  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required int serviceId,
  });

  Future<Either<Failure, TaskModel>> fetchTaskById({required int taskId});


}

class AdsViewDataSourceImpl extends AdsViewDataSource {
  final Dio _dio;

  AdsViewDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, ServiceModel>> fetchServiceById({
    required int serviceId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchService(serviceId));
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
  Future<Either<Failure, TaskModel>> fetchTaskById({
    required int taskId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchTask(taskId));
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
  Future<Either<Failure, Vacancy>> fetchVacancyById({
    required int vacancyId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.fetchVacancy(vacancyId));
      if (response.statusCode == 200) {
        return Right(Vacancy.fromMap(response.data));
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
