import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/models/vacancy.dart';

abstract class FavoritesDataSource {
  Future<Either<Failure, List<Vacancy>>> fetchVacancyFavorites();

  Future<Either<Failure, List<ServiceModel>>> fetchServiceFavorites();

  Future<Either<Failure, List<TaskModel>>> fetchTaskFavorites();
}

class FavoritesDataSourceImpl extends FavoritesDataSource {
  final Dio _dio;

  FavoritesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, List<ServiceModel>>> fetchServiceFavorites() async {
    try {
      final response = await _dio.get(ApiConstants.serviceFavorite);
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) {
            return ServiceModel.fromMap(e);
          }).toList(),
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
  Future<Either<Failure, List<TaskModel>>> fetchTaskFavorites() async {
    try {
      final response = await _dio.get(ApiConstants.taskFavorite);
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) {
            return TaskModel.fromJson(e);
          }).toList(),
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
  Future<Either<Failure, List<Vacancy>>> fetchVacancyFavorites() async {
    try {
      final response = await _dio.get(ApiConstants.vacancyFavorite);
      if (response.statusCode == 200) {
        return Right(
          (response.data as List).map((e) {
            return Vacancy.fromMap(e);
          }).toList(),
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
}
