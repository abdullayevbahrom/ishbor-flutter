import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

abstract class YandexDataSource {
  Future<Either<Failure, GeocodeResponse>> fetchPositionFromAddress({
    required String query,
    required String language,
  });

  Future<Either<Failure, List<String>>> fetchSuggestionsByQuery({
    required String search,
    required String language,
  });

  Future<Either<Failure, GeocodeResponse>> fetchAddressFromPosition({
    required String geocodeApiKey,
    required double lat,
    required double long,
    required String language,
  });
}

class YandexDataSourceImpl extends YandexDataSource {
  final Dio _dio;

  YandexDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, GeocodeResponse>> fetchAddressFromPosition({
    required String geocodeApiKey,
    required double lat,
    required double long,
    required String language,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.yandexGeocodePositionToAddress(
          geocodeApiKey: geocodeApiKey,
          lat: lat,
          long: long,
          language: language,
        ),
      );

      if (response.statusCode == 200) {
        return Right(GeocodeResponse.fromJson(response.data));
      } else {
        return Left(Failure(message: response.data));
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
  Future<Either<Failure, GeocodeResponse>> fetchPositionFromAddress({
    required String query,
    required String language,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.yandexGeocodeAddressToPosition(
          geocodeApiKey: ApiConstants.yandexGeocodeKey,
          query: query,
          language: language,
        ),
      );

      if (response.statusCode == 200) {
        return Right(GeocodeResponse.fromJson(response.data));
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
  Future<Either<Failure, List<String>>> fetchSuggestionsByQuery({
    required String search,
    required String language,
  }) async {
    try {
      final response = await _dio.get(
        ApiConstants.yandexGeoSuggest(
          search: search,
          suggestApiKey: ApiConstants.yandexSuggestKey,
          language: language,
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['results'] != null) {
          final List list = response.data['results'];

          return Right(
            list
                .map(
                  (e) => (e['address']?['formatted_address'] ?? '').toString(),
                )
                .toList(),
          );
        } else {
          return Right([]);
        }
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
