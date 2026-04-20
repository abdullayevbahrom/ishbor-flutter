
class AddressModel {
  final int? id;
  final String? addressLine;
  final double? latitude;
  final double? longitude;

  AddressModel({this.id, this.addressLine, this.latitude, this.longitude});


  static AddressModel fromJson(Map<String, dynamic> data) {
    return AddressModel(
      id: data['id'],
      addressLine: data['address_line'],
      latitude: data['latitude'],
      longitude: data['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressLine != null) 'addressLine': addressLine,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
