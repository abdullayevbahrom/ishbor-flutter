import 'package:flutter/foundation.dart';

import '../../../../models/api_model_utils.dart';

class CitiesList {
  final List<City> cities;
  final int currentPageNumber;
  final int numItemsPerPage;
  final int totalCount;

  CitiesList({
    required this.cities,
    this.currentPageNumber = 1,
    this.numItemsPerPage = 0,
    this.totalCount = 0,
  });

  factory CitiesList.fromMap(dynamic source) {
    final payload = _payload(source);
    final cities = _citiesFromPayload(payload);
    final currentPageNumber =
        intValue(
          payload['current_page_number'] ?? payload['currentPageNumber'],
        ) ??
        intValue(payload['page']) ??
        1;
    final numItemsPerPage =
        intValue(payload['num_items_per_page'] ?? payload['numItemsPerPage']) ??
        cities.length;
    final totalCount =
        intValue(payload['total_count'] ?? payload['totalCount']) ??
        cities.length;

    if (kDebugMode &&
        payload.isNotEmpty &&
        payload['cities'] == null &&
        payload['items'] == null) {
      debugPrint(
        '[FIX][catalog] CitiesList.fromMap normalized nonstandard payload: keys=${payload.keys.toList()}',
      );
    }

    return CitiesList(
      cities: cities,
      currentPageNumber: currentPageNumber,
      numItemsPerPage: numItemsPerPage,
      totalCount: totalCount,
    );
  }

  Map<String, dynamic> toMap() => {
    'cities': cities.map((city) => city.toMap()).toList(),
    'current_page_number': currentPageNumber,
    'num_items_per_page': numItemsPerPage,
    'total_count': totalCount,
  };
}

class City {
  final String id;
  final String name;
  final Coordinates coords;

  City({required this.name, required this.coords, this.id = ''});

  factory City.fromMap(dynamic source) {
    final map = asMap(source);
    final coordsSource = map['coords'] ?? map['coordinates'] ?? map['location'];

    return City(
      id: stringValue(map['id']) ?? '',
      name: stringValue(map['name'] ?? map['title'] ?? map['value']) ?? '',
      coords:
          coordsSource is Map || coordsSource is String
              ? Coordinates.fromMap(coordsSource)
              : Coordinates.empty(),
    );
  }

  Map<String, dynamic> toMap() => {
    if (id.isNotEmpty) 'id': id,
    'name': name,
    'coords': coords.toMap(),
  };
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.empty() => Coordinates(lat: 0, lng: 0);

  factory Coordinates.fromMap(dynamic source) {
    if (source is String) {
      return Coordinates.empty();
    }

    final map = asMap(source);
    return Coordinates(
      lat: doubleValue(map['lat'] ?? map['latitude']) ?? 0,
      lng: doubleValue(map['lng'] ?? map['longitude']) ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {'lat': lat, 'lng': lng};
}

Map<String, dynamic> _payload(dynamic source) {
  if (source is List) {
    return {'items': source};
  }

  final map = asMap(source);
  final data = map['data'];
  if (data is Map) {
    return asMap(data);
  }

  if (data is List) {
    return {'items': data};
  }

  return map;
}

List<City> _citiesFromPayload(Map<String, dynamic> payload) {
  final items =
      payload['cities'] ??
      payload['items'] ??
      payload['data'] ??
      const <dynamic>[];

  if (items is! List) {
    return const <City>[];
  }

  return items.map((item) => City.fromMap(item)).toList(growable: false);
}
