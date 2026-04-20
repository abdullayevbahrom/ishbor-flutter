import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/map/data/datasource/location_info_datasource.dart';
import 'package:top_jobs/feature/map/data/model/location_info.dart';
import 'package:top_jobs/feature/map/domain/repository/location_info.dart';

import '../model/suggested_location.dart';

class LocationInfoRepositoryImpl extends LocationInfoRepository {
  final LocationInfoDataSource _locationInfoDataSource;

  LocationInfoRepositoryImpl({
    required LocationInfoDataSource locationInfoDataSource,
  }) : _locationInfoDataSource = locationInfoDataSource;

  @override
  Future<Either<Failure, LocationInfo>> fetchLocationFromPoint({
    required LatLng point,
  }) async {
    final result = await _locationInfoDataSource.fetchLocationFromPoint(
      point: point,
    );

    return result.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, List<SuggestedLocation>>> fetchSuggestionsFromQuery(
    String query,
  ) async {
    final response = await _locationInfoDataSource.fetchSuggestionsFromQuery(
      query,
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
