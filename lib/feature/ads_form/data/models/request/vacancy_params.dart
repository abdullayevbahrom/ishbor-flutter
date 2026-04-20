import 'dart:convert';
import 'dart:io';

import '../../../../../models/address.dart';

class VacancyParams {
  final String? title;
  final String? workTime;
  final List<TagModel> tags;
  final String? city;
  final AddressModel? address;
  final String? description;
  final String? phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final String? telegram;
  final String? salaryMin;
  final String? salaryMax;
  final String? skills;
  final String? shortDescription;
  final String? whoCanRespond;
  final bool? partialJobOpportunity;
  final bool? salaryIsNegotiable;
  final String? employmentType; // faqat bitta string yuboriladi
  final List<String> jobModes;
  final List<File> uploadedImages;
  final List<int> categories; // server string "[1,2,3]"

  VacancyParams({
    this.title,
    this.workTime,
    this.tags = const [],
    this.city,
    this.address,
    this.description,
    this.phoneNumber,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
    this.telegram,
    this.salaryMin,
    this.salaryMax,
    this.skills,
    this.shortDescription,
    this.whoCanRespond,
    this.partialJobOpportunity,
    this.salaryIsNegotiable,
    this.employmentType,
    this.jobModes = const [],
    this.uploadedImages = const [],
    this.categories = const [],
  });

  VacancyParams copyWith({
    String? title,
    String? workTime,
    List<TagModel>? tags,
    String? city,
    AddressModel? address,
    String? description,
    String? phoneNumber,
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    String? telegram,
    String? salaryMin,
    String? salaryMax,
    String? skills,
    String? shortDescription,
    String? whoCanRespond,
    bool? partialJobOpportunity,
    String? employmentType,
    List<String>? jobModes,
    List<File>? uploadedImages,
    List<int>? categories,
  }) {
    return VacancyParams(
      title: title ?? this.title,
      workTime: workTime ?? this.workTime,
      tags: tags ?? this.tags,
      city: city ?? this.city,
      address: address ?? this.address,
      description: description ?? this.description,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      telegram: telegram ?? this.telegram,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      skills: skills ?? this.skills,
      shortDescription: shortDescription ?? this.shortDescription,
      whoCanRespond: whoCanRespond ?? this.whoCanRespond,
      partialJobOpportunity:
          partialJobOpportunity ?? this.partialJobOpportunity,
      employmentType: employmentType ?? this.employmentType,
      salaryIsNegotiable: salaryIsNegotiable ?? this.salaryIsNegotiable,
      jobModes: jobModes ?? this.jobModes,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      if (workTime != null) 'workTime': workTime,
      if (tags.isNotEmpty) 'tags': tags.map((e) => e.toJson()).toList(),
      'city': city,
      'address': address?.toJson(),
      'description': description,
      'phoneNumber': "+998${phoneNumber!}",
      if ((phoneNumber1 ?? '').isNotEmpty)
        'phoneNumber1': "+998${phoneNumber1!}",
      if ((phoneNumber2 ?? '').isNotEmpty)
        'phoneNumber2': "+998${phoneNumber2!}",
      if ((phoneNumber3 ?? '').isNotEmpty)
        'phoneNumber3': "+998${phoneNumber3!}",
      if (telegram != null) 'telegram': telegram,
      if (!(salaryIsNegotiable ?? false)) 'salaryMin': salaryMin,
      if (!(salaryIsNegotiable ?? false)) 'salaryMax': salaryMax,
      if ((skills ?? '').isNotEmpty) 'skills[]': skills!.split(','),
      if (shortDescription != null) 'shortDescription': shortDescription,
      if ((whoCanRespond ?? '').isNotEmpty) 'whoCanRespond[]': whoCanRespond,
      if (partialJobOpportunity ?? false)
        'partialJobOpportunity': partialJobOpportunity,
      if (employmentType != null) 'employmentType': employmentType,
      if (jobModes.isNotEmpty) 'jobModes': jobModes,
      'categories': jsonEncode(categories),
    };
  }

  factory VacancyParams.fromJson(Map<String, dynamic> json) {
    return VacancyParams(
      title: json['title'] as String?,
      workTime: json['workTime'] as String?,
      tags:
          (json['tags'] as List? ?? [])
              .map((e) => TagModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      city: json['city'] as String?,
      address:
          json['address'] != null
              ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
              : null,
      description: json['description'] as String?,
      phoneNumber: (json['phoneNumber'] as String?)?.replaceFirst('+998', ''),
      phoneNumber1: (json['phoneNumber1'] as String?)?.replaceFirst('+998', ''),
      phoneNumber2: (json['phoneNumber2'] as String?)?.replaceFirst('+998', ''),
      phoneNumber3: (json['phoneNumber3'] as String?)?.replaceFirst('+998', ''),
      telegram: json['telegram'] as String?,
      salaryMin: json['salaryMin'] as String?,
      salaryMax: json['salaryMax'] as String?,
      skills: (json['skills[]'] as List?)?.join(',') ?? '',
      shortDescription: json['shortDescription'] as String?,
      whoCanRespond:
          (json['whoCanRespond[]'] is List)
              ? (json['whoCanRespond[]'] as List).join(',')
              : (json['whoCanRespond[]'] as String?),
      partialJobOpportunity: json['partialJobOpportunity'] as bool?,
      employmentType: json['employmentType'] as String?,
      jobModes: List<String>.from(json['jobModes'] ?? []),
      salaryIsNegotiable: json['salaryNegotaible'] as bool?,
      categories: (json['categories'] != null && (json['categories'] as String).isNotEmpty)
          ? List<int>.from(jsonDecode(json['categories']) as List)
          : [],

    );
  }
}

class TagModel {
  final int? id;
  final String? name;

  TagModel({this.id, this.name});

  TagModel copyWith({int? id, String? name}) {
    return TagModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(id: json['id'] as int?, name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
