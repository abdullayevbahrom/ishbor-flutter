import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/map/data/model/location_info.dart';
import 'package:top_jobs/feature/map/data/model/suggested_location.dart';

abstract class LocationInfoDataSource {
  Future<Either<Failure, LocationInfo>> fetchLocationFromPoint({
    required LatLng point,
  });

  Future<Either<Failure, List<SuggestedLocation>>> fetchSuggestionsFromQuery(
    String query,
  );
}

class LocationInfoDataSourceImpl extends LocationInfoDataSource {
  final Dio _dio;

  LocationInfoDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, LocationInfo>> fetchLocationFromPoint({
    required LatLng point,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.reverseLocation,
        options: Options(
          headers: {'User-Agent': 'IshBor/1.0 (jahongireshonqulov17@gmail.com)'},
        ),
        queryParameters: {
          "format": "jsonv2",
          "lat": "${point.latitude}",
          "lon": "${point.longitude}",
          // "key": "9ddd662e32464da7b43c8dd531d9678f",
        },
      );

      if (response.statusCode == 200) {
        return Right(LocationInfo.fromMap(response.data));
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
      debugPrint("Error:$e");
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<SuggestedLocation>>> fetchSuggestionsFromQuery(
    String query,
  ) async {
    try {
      final response = await _dio.get(
        ApiConstants.searchLocation,
        options: Options(
          headers: {'User-Agent': 'IshBor/2.0 (jahongir@gmail.com)'},
        ),
        queryParameters: {
          "format": "jsonv2",
          'limit': 5,
          'q': query,

          // "key": "9ddd662e32464da7b43c8dd531d9678f",
        },
      );

      if (response.statusCode == 200) {
        return Right(SuggestedLocation.fromJsonList(response.data));
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
      debugPrint("Error:$e");
      rethrow;
    }
  }
}
