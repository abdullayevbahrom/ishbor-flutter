import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/ads_view/data/models/ads_contact_model.dart';

abstract class AdsContactDataSource {
  Future<Either<Failure, AdsContactModel>> fetchVacancyContact({
    required int vacancyId,
  });

  Future<Either<Failure, AdsContactModel>> fetchServiceContact({
    required int serviceId,
  });

  Future<Either<Failure, AdsContactModel>> fetchTaskContact({
    required int taskId,
  });
}

class AdsContactDataSourceImpl implements AdsContactDataSource {
  final Dio _dio;

  AdsContactDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, AdsContactModel>> fetchServiceContact({
    required int serviceId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.serviceContact(serviceId));
      if (response.statusCode == 200 && response.data != null) {
        return Right(AdsContactModel.fromJson(response.data));
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
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, AdsContactModel>> fetchTaskContact({
    required int taskId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.taskContact(taskId));
      if (response.statusCode == 200 && response.data != null) {
        return Right(AdsContactModel.fromJson(response.data));
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
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, AdsContactModel>> fetchVacancyContact({
    required int vacancyId,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.vacancyContact(vacancyId));
      if (response.statusCode == 200 && response.data != null) {
        return Right(AdsContactModel.fromJson(response.data));
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
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
