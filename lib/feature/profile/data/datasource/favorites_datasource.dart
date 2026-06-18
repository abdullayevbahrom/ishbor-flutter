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

  @override
  Future<Either<Failure, List<ServiceModel>>> fetchServiceFavorites() async {
    try {
      debugPrint('[SERVICE][favorite] GET ${ApiConstants.serviceFavorite}');
      final response = await _dio.get(ApiConstants.serviceFavorite);
      if (response.statusCode == 200) {
        debugPrint('[SERVICE][favorite] loaded status=${response.statusCode}');
        return Right(
          _unwrapList(response.data).map((e) {
            return ServiceModel.fromMap(e);
          }).toList(),
        );
      } else {
        debugPrint(
          '[SERVICE][favorite][warn] status=${response.statusCode} payload=${response.data}',
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
  Future<Either<Failure, List<TaskModel>>> fetchTaskFavorites() async {
    try {
      if (kDebugMode) {
        debugPrint('[TASK][favorite] GET ${ApiConstants.taskFavorite}');
      }
      final response = await _dio.get(ApiConstants.taskFavorite);
      if (response.statusCode == 200) {
        if (kDebugMode) {
          debugPrint('[TASK][favorite] loaded status=${response.statusCode}');
        }
        return Right(
          _unwrapList(response.data).map((e) {
            return TaskModel.fromJson(e);
          }).toList(),
        );
      } else {
        debugPrint(
          '[TASK][favorite][warn] status=${response.statusCode} payload=${response.data}',
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
  Future<Either<Failure, List<Vacancy>>> fetchVacancyFavorites() async {
    try {
      final response = await _dio.get(ApiConstants.vacancyFavorite);
      if (response.statusCode == 200) {
        return Right(
          _unwrapList(response.data).map((e) {
            return Vacancy.fromMap(e);
          }).toList(),
        );
      } else {
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
