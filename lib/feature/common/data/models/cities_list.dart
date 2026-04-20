class CitiesList {
  final List<City> cities;

  CitiesList({required this.cities});

  factory CitiesList.fromMap(Map<String, dynamic> map) {
    return CitiesList(
      cities: List<City>.from(
        (map['cities'] ?? []).map((city) => City.fromMap(city)),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
    'cities': cities.map((city) => city.toMap()).toList(),
  };
}

class City {
  final String name;
  final Coordinates coords;

  City({required this.name, required this.coords});

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
      coords: Coordinates.fromMap(map['coords']),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'coords': coords.toMap(),
  };
}

class Coordinates {
  final double lat;
  final double lng;

  Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromMap(Map<String, dynamic> map) {
    return Coordinates(
      lat: (map['lat'] as num).toDouble(),
      lng: (map['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'lat': lat,
    'lng': lng,
  };
}
