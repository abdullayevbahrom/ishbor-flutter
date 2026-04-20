import 'dart:io';

class ServiceCreateRequest {
  final int? serviceId;
  final String title;
  final List<int>? categoryIds;
  final String city;
  final String description;
  final String price;
  final String? addressLine;
  final double? latitude;
  final double? longitude;
  final bool negotiable;
  final List<File> uploadedImages;
  final String phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;

  ServiceCreateRequest({
    this.serviceId,
    required this.title,
    this.categoryIds,
    required this.description,
    required this.price,
    required this.addressLine,
    this.latitude,
    this.longitude,
    required this.negotiable,
    required this.uploadedImages,
    required this.city,
    required this.phoneNumber,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
  });
}
