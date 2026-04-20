import 'dart:convert';
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
  final int? vacancyId;
  final String title;
  final int? categories;
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
    this.categories,
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
      phoneNumber: json['phoneNumber'],
      images: json['images'],
      title: json['title'],
      categories:
          json['categories'] != null ? (jsonDecode(json['categories'])) : null,
      city: json['city'],
      description: json['description'],
      address: AddressModel.fromJson(json['address']),
      salaryMin: json['salaryMin'],
      salaryMax: json['salaryMax'],
      skills: List<String>.from(json['skills']),
      shortDescription: json['shortDescription'],
      whoCanRespond: json['whoCanRespond'],
      employmentType: json['employmentType'],
      jobModes: List<String>.from(json['jobModes']),
      partialJobOpportunity: json['partialJobOpportunity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (categories != null) 'categories': jsonEncode(categories),
      'city': city,
      'description': description,
      if (address != null) 'address': address!,
      'salaryMin': salaryMin.toString(),
      'salaryMax': salaryMax.toString(),
      'skills': skills,
      'shortDescription': shortDescription,
      'whoCanRespond': whoCanRespond,
      'employmentType': employmentType,
      'jobModes': jobModes,
      if (partialJobOpportunity != null)
        'partialJobOpportunity': partialJobOpportunity,
    };
  }

  VacancyRequest copyWith({
    String? title,
    int? categories,
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
      phoneNumber1: phoneNumber1??this.phoneNumber1,
      phoneNumber2: phoneNumber1??this.phoneNumber2,
      phoneNumber3: phoneNumber1??this.phoneNumber3,

    );
  }
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
