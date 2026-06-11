class LocationFilterModel {
  final double lat;
  final double lng;
  final double distance;
  final List<String> categories;

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
      categories:
          (json['category_ids'] as List? ?? json['categories'] as List? ?? [])
              .map((value) => value.toString())
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'distance_km': distance,
      if (categories.isNotEmpty) 'category_ids': categories,
    };
  }

  LocationFilterModel copyWith({
    double? lat,
    double? lng,
    double? distance,
    List<String>? categories,
  }) {
    return LocationFilterModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      distance: distance ?? this.distance,
      categories: categories ?? this.categories,
    );
  }
}
