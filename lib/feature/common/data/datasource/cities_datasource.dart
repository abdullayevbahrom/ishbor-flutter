import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/cities_list.dart';

abstract class CitiesDataSource {
  Future<Either<Failure, CitiesList>> fetchCities();
}

class CitiesDataSourceImpl extends CitiesDataSource {
  final Dio _dio;

  CitiesDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, CitiesList>> fetchCities() async {
    try {
      final response = await _dio.get(ApiConstants.cities);
      if (response.statusCode == 200) {
        return Right(CitiesList.fromMap(response.data));
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
