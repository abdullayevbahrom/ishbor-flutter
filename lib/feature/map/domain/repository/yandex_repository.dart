import 'package:dartz/dartz.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../core/network/api_http.dart';

abstract class YandexRepository{
  Future<Either<Failure, GeocodeResponse>> fetchAddressFromPosition({
    required String geocodeApiKey,
    required double lat,
    required double long,
    required String language,
  });

  Future<Either<Failure, GeocodeResponse>> fetchPositionFromAddress({
    required String query,
    required String language,
  });

  Future<Either<Failure, List<String>>> fetchSuggestionsByQuery({
    required String search,
    required String language,
  });

}