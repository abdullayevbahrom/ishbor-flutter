import 'api_model_utils.dart';

class AddressModel {
  final String? id;
  final String? addressLine;
  final double? latitude;
  final double? longitude;

  AddressModel({this.id, this.addressLine, this.latitude, this.longitude});

  static AddressModel fromJson(dynamic source) {
    if (source is String) {
      return AddressModel(addressLine: source);
    }

    final data = unwrapData(source);
    return AddressModel(
      id: stringValue(data['id']),
      addressLine: stringValue(data['address_line'] ?? data['addressLine']),
      latitude: doubleValue(data['latitude'] ?? data['lat']),
      longitude: doubleValue(data['longitude'] ?? data['lng']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (addressLine != null) 'address_line': addressLine,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
    };
  }
}
