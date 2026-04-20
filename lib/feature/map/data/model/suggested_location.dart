class SuggestedLocation {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? classType;
  final String? type;
  final int? placeRank;
  final double? importance;
  final String? addresstype;
  final String? name;
  final String? displayName;
  final List<String>? boundingbox;

  SuggestedLocation({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.classType,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.boundingbox,
  });

  factory SuggestedLocation.fromJson(Map<String, dynamic> json) {
    return SuggestedLocation(
      placeId: json['place_id'],
      licence: json['licence'],
      osmType: json['osm_type'],
      osmId: json['osm_id'],
      lat: json['lat'],
      lon: json['lon'],
      classType: json['class'],
      type: json['type'],
      placeRank: json['place_rank'],
      importance: (json['importance'] as num).toDouble(),
      addresstype: json['addresstype'],
      name: json['name'],
      displayName: json['display_name'],
      boundingbox: List<String>.from(json['boundingbox']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_id': placeId,
      'licence': licence,
      'osm_type': osmType,
      'osm_id': osmId,
      'lat': lat,
      'lon': lon,
      'class': classType,
      'type': type,
      'place_rank': placeRank,
      'importance': importance,
      'addresstype': addresstype,
      'name': name,
      'display_name': displayName,
      'boundingbox': boundingbox,
    };
  }

  SuggestedLocation copyWith({
    int? placeId,
    String? licence,
    String? osmType,
    int? osmId,
    String? lat,
    String? lon,
    String? classType,
    String? type,
    int? placeRank,
    double? importance,
    String? addresstype,
    String? name,
    String? displayName,
    List<String>? boundingbox,
  }) {
    return SuggestedLocation(
      placeId: placeId ?? this.placeId,
      licence: licence ?? this.licence,
      osmType: osmType ?? this.osmType,
      osmId: osmId ?? this.osmId,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      classType: classType ?? this.classType,
      type: type ?? this.type,
      placeRank: placeRank ?? this.placeRank,
      importance: importance ?? this.importance,
      addresstype: addresstype ?? this.addresstype,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      boundingbox: boundingbox ?? this.boundingbox,
    );
  }

  static List<SuggestedLocation> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SuggestedLocation.fromJson(json)).toList();
  }
}
