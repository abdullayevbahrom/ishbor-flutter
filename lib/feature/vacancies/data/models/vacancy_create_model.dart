import 'dart:io';

import '../../../../models/address.dart';

// class vacancyCreateModel {
//   final String title;
//   final List<int>? categoryIds;
//   final String city;
//   final String description;
//   final String price;
//   final String addressLine;
//   final double? latitude;
//   final double? longitude;
//   final String salaryMin;
//   final String salaryMax;
//   final String skills;
//   final String shortDescription;
//   final bool negotiable;
//   final String? employmentType;
//   final String? jobMOdes;
//   final bool? partialJobOpportunity;
//
//   vacancyCreateModel({
//     required this.title,
//     required this.categoryIds,
//     required this.city,
//     required this.description,
//     required this.price,
//     required this.addressLine,
//     required this.latitude,
//     required this.longitude,
//     required this.negotiable,
//     required this.salaryMin,
//     required this.salaryMax,
//     required this.skills,
//     required this.shortDescription,
//     this.employmentType,
//     this.jobMOdes,
//     this.partialJobOpportunity,
//   });
// }

class VacancyRequest {
  final String? vacancyId;
  final String title;
  final String? workTime;
  final List<String> categories;
  final String city;
  final String description;
  final AddressModel? address;
  final int? salaryMin;
  final int? salaryMax;
  final List<String> skills;
  final String shortDescription;
  final List<String> whoCanRespond;
  final String employmentType;
  final List<String> jobModes;
  final bool? partialJobOpportunity;
  final List<File> images;
  final String phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;

  VacancyRequest({
    this.vacancyId,
    required this.title,
    this.workTime,
    this.categories = const [],
    required this.city,
    required this.description,
    required this.address,
    this.salaryMin,
    this.salaryMax,
    required this.skills,
    required this.shortDescription,
    required this.whoCanRespond,
    required this.employmentType,
    required this.jobModes,
    this.partialJobOpportunity,
    required this.images,
    required this.phoneNumber,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
  });

  factory VacancyRequest.fromJson(Map<String, dynamic> json) {
    return VacancyRequest(
      phoneNumber: json['phone_number'],
      images: List<File>.from(json['images'] ?? const []),
      title: json['title'],
      workTime: json['work_time'],
      categories:
          (json['category_ids'] as List? ??
                  json['categories'] as List? ??
                  const [])
              .map((value) => value.toString())
              .toList(),
      city: json['city'],
      description: json['description'],
      address:
          json['address'] != null
              ? AddressModel.fromJson(json['address'])
              : null,
      salaryMin: json['salary_min'],
      salaryMax: json['salary_max'],
      skills: List<String>.from(json['skills']),
      shortDescription: json['short_description'],
      whoCanRespond: List<String>.from(json['who_can_respond'] ?? const []),
      employmentType: json['employment_type'],
      jobModes: List<String>.from(json['job_modes'] ?? const []),
      partialJobOpportunity: json['partial_job_opportunity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if ((workTime ?? '').isNotEmpty) 'work_time': workTime,
      if (categories.isNotEmpty) 'category_ids': categories,
      'city': city,
      'description': description,
      if (address != null) 'address': address!.toJson(),
      if (salaryMin != null) 'salary_min': salaryMin,
      if (salaryMax != null) 'salary_max': salaryMax,
      if (skills.isNotEmpty) 'skills': skills,
      if (shortDescription.isNotEmpty) 'short_description': shortDescription,
      if (whoCanRespond.isNotEmpty) 'who_can_respond': whoCanRespond,
      if (employmentType.isNotEmpty) 'employment_type': employmentType,
      if (jobModes.isNotEmpty) 'job_modes': jobModes,
      if (partialJobOpportunity != null)
        'partial_job_opportunity': partialJobOpportunity,
      'phone_number': _normalizePhone(phoneNumber),
      if ((phoneNumber1 ?? '').isNotEmpty)
        'phone_number1': _normalizePhone(phoneNumber1),
      if ((phoneNumber2 ?? '').isNotEmpty)
        'phone_number2': _normalizePhone(phoneNumber2),
      if ((phoneNumber3 ?? '').isNotEmpty)
        'phone_number3': _normalizePhone(phoneNumber3),
    };
  }

  VacancyRequest copyWith({
    String? title,
    String? workTime,
    List<String>? categories,
    String? city,
    String? description,
    AddressModel? address,
    int? salaryMin,
    int? salaryMax,
    List<String>? skills,
    String? shortDescription,
    List<String>? whoCanRespond,
    String? employmentType,
    List<String>? jobModes,
    bool? partialJobOpportunity,
    List<File>? images,
    String? phoneNumber,
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
  }) {
    return VacancyRequest(
      images: images ?? this.images,
      title: title ?? this.title,
      workTime: workTime ?? this.workTime,
      categories: categories ?? this.categories,
      city: city ?? this.city,
      description: description ?? this.description,
      address: address ?? this.address,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      skills: skills ?? this.skills,
      shortDescription: shortDescription ?? this.shortDescription,
      whoCanRespond: whoCanRespond ?? this.whoCanRespond,
      employmentType: employmentType ?? this.employmentType,
      jobModes: jobModes ?? this.jobModes,
      partialJobOpportunity:
          partialJobOpportunity ?? this.partialJobOpportunity,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
    );
  }
}

String _normalizePhone(String? value) {
  final digits = (value ?? '').replaceAll(RegExp(r'[^0-9+]'), '').trim();
  if (digits.isEmpty) {
    return '';
  }
  if (digits.startsWith('+998')) {
    return digits;
  }
  if (digits.startsWith('998')) {
    return '+$digits';
  }
  return '+998$digits';
}

// class Address {
//   final String addressLine;
//   final double? latitude;
//   final double? longitude;
//
//   Address({required this.addressLine, this.latitude, this.longitude});
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       addressLine: json['addressLine'],
//       latitude: (json['latitude'] != null) ? json['latitude'].toDouble() : null,
//       longitude:
//           (json['longitude'] != null) ? json['longitude'].toDouble() : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'addressLine': addressLine,
//       if (latitude != null) 'latitude': latitude,
//       if (longitude != null) 'longitude': longitude,
//     };
//   }
//
//   Address copyWith({String? addressLine, double? latitude, double? longitude}) {
//     return Address(
//       addressLine: addressLine ?? this.addressLine,
//       latitude: latitude ?? this.latitude,
//       longitude: longitude ?? this.longitude,
//     );
//   }
// }
