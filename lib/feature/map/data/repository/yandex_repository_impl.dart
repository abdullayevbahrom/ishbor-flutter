import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/map/data/datasource/yandex_datasource.dart';
import 'package:top_jobs/feature/map/domain/repository/yandex_repository.dart';
import 'package:yandex_geocoder/src/models/response/geocode_response.dart';

class YandexRepositoryImpl extends YandexRepository {
  final YandexDataSource _yandexDataSource;

  YandexRepositoryImpl(this._yandexDataSource);

  @override
  Future<Either<Failure, GeocodeResponse>> fetchAddressFromPosition({
    required String geocodeApiKey,
    required double lat,
    required double long,
    required String language,
  }) async {
    final response = await _yandexDataSource.fetchAddressFromPosition(
      geocodeApiKey: geocodeApiKey,
      lat: lat,
      long: long,
      language: language,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, GeocodeResponse>> fetchPositionFromAddress({
    required String query,
    required String language,
  }) async {
    final response = await _yandexDataSource.fetchPositionFromAddress(
      query: query,
      language: language,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, List<String>>> fetchSuggestionsByQuery({
    required String search,
    required String language,
  }) async {
    final response = await _yandexDataSource.fetchSuggestionsByQuery(
      search: search,
      language: language,
    );
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
