import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/network/api_http.dart';
import '../../data/model/location_info.dart';
import '../../data/model/suggested_location.dart';

abstract class LocationInfoRepository {
  Future<Either<Failure, LocationInfo>> fetchLocationFromPoint({
    required LatLng point,
  });

  Future<Either<Failure, List<SuggestedLocation>>> fetchSuggestionsFromQuery(String query);

}
