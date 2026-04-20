import 'dart:io';

class TaskRequestModel {
  final int? taskId;
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
  final String startTime;
  final String exprTime;
  final String paymentMethod;
  final String phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;

  TaskRequestModel({
    this.taskId,
    required this.paymentMethod,
    required this.title,
    this.categoryIds,
    required this.city,
    required this.description,
    required this.price,
    this.addressLine,
    this.latitude,
    this.longitude,
    required this.negotiable,
    required this.uploadedImages,
    required this.startTime,
    required this.exprTime,
    required this.phoneNumber,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
  });
}
