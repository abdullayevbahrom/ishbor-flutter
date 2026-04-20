class LocationInfo {
  final int? placeId;
  final String? licence;
  final String? osmType;
  final int? osmId;
  final String? lat;
  final String? lon;
  final String? category;
  final String? type;
  final int? placeRank;
  final double? importance;
  final String? addresstype;
  final String? name;
  final String? displayName;
  final Address? address;
  final List<String>? boundingBox;

  LocationInfo({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.category,
    this.type,
    this.placeRank,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.boundingBox,
  });

  factory LocationInfo.fromMap(Map<String, dynamic> map) {
    return LocationInfo(
      placeId: map['place_id'],
      licence: map['licence'],
      osmType: map['osm_type'],
      osmId: map['osm_id'],
      lat: map['lat'],
      lon: map['lon'],
      category: map['category'],
      type: map['type'],
      placeRank: map['place_rank'],
      importance: map['importance']?.toDouble(),
      addresstype: map['addresstype'],
      name: map['name'],
      displayName: map['display_name'],
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      boundingBox: map['boundingbox'] != null ? List<String>.from(map['boundingbox']) : null,
    );
  }
}

class Address {
  final String? road;
  final String? neighbourhood;
  final String? county;
  final String? city;
  final String? state;
  final String? postcode;
  final String? iso3166Lvl4;
  final String? country;
  final String? countryCode;

  Address({
    this.road,
    this.neighbourhood,
    this.county,
    this.city,
    this.state,
    this.postcode,
    this.iso3166Lvl4,
    this.country,
    this.countryCode,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      road: map['road'],
      neighbourhood: map['neighbourhood'],
      county: map['county'],
      city: map['city'],
      state: map['state'],
      postcode: map['postcode'],
      iso3166Lvl4: map['ISO3166-2-lvl4'],
      country: map['country'],
      countryCode: map['country_code'],
    );
  }
}
