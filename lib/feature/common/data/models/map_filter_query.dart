import 'dart:convert';

class LocationFilterModel {
  final double lat;
  final double lng;
  final double distance;
  final List<int> categories;

  LocationFilterModel({
    required this.lat,
    required this.lng,
    required this.distance,
    required this.categories,
  });

  factory LocationFilterModel.fromJson(Map<String, dynamic> json) {
    return LocationFilterModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      categories: List<int>.from(json['categories']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'distance': distance,
      if (categories.isNotEmpty) 'categories': jsonEncode(categories),
    };
  }

  LocationFilterModel copyWith({
    double? lat,
    double? lng,
    double? distance,
    List<int>? categories,
  }) {
    return LocationFilterModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      categories: categories ?? this.categories,
    );
  }
}
