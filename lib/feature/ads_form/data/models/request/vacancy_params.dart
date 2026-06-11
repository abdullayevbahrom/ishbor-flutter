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
  final String? employmentType;
  final List<String> jobModes;
  final List<File> uploadedImages;
  final List<String> categories;

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
    List<String>? categories,
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
      if (workTime != null) 'work_time': workTime,
      if (tags.isNotEmpty) 'tags': tags.map((e) => e.toJson()).toList(),
      'city': city,
      'address': address?.toJson(),
      'description': description,
      if (phoneNumber != null) 'phone_number': _normalizePhone(phoneNumber),
      if ((phoneNumber1 ?? '').isNotEmpty)
        'phone_number1': _normalizePhone(phoneNumber1),
      if ((phoneNumber2 ?? '').isNotEmpty)
        'phone_number2': _normalizePhone(phoneNumber2),
      if ((phoneNumber3 ?? '').isNotEmpty)
        'phone_number3': _normalizePhone(phoneNumber3),
      if (telegram != null) 'telegram': telegram,
      if (!(salaryIsNegotiable ?? false)) 'salary_min': salaryMin,
      if (!(salaryIsNegotiable ?? false)) 'salary_max': salaryMax,
      if ((skills ?? '').isNotEmpty) 'skills': skills!.split(','),
      if (shortDescription != null) 'short_description': shortDescription,
      if ((whoCanRespond ?? '').isNotEmpty) 'who_can_respond': whoCanRespond,
      if (partialJobOpportunity ?? false)
        'partial_job_opportunity': partialJobOpportunity,
      if (employmentType != null) 'employment_type': employmentType,
      if (jobModes.isNotEmpty) 'job_modes': jobModes,
      if (categories.isNotEmpty) 'category_ids': categories,
    };
  }

  factory VacancyParams.fromJson(Map<String, dynamic> json) {
    return VacancyParams(
      title: json['title'] as String?,
      workTime: json['work_time'] as String?,
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
      phoneNumber: (json['phone_number'] as String?)?.replaceFirst('+998', ''),
      phoneNumber1: (json['phone_number1'] as String?)?.replaceFirst(
        '+998',
        '',
      ),
      phoneNumber2: (json['phone_number2'] as String?)?.replaceFirst(
        '+998',
        '',
      ),
      phoneNumber3: (json['phone_number3'] as String?)?.replaceFirst(
        '+998',
        '',
      ),
      telegram: json['telegram'] as String?,
      salaryMin: json['salary_min'] as String?,
      salaryMax: json['salary_max'] as String?,
      skills: (json['skills'] as List?)?.join(',') ?? '',
      shortDescription: json['short_description'] as String?,
      whoCanRespond:
          (json['who_can_respond'] is List)
              ? (json['who_can_respond'] as List).join(',')
              : (json['who_can_respond'] as String?),
      partialJobOpportunity: json['partial_job_opportunity'] as bool?,
      employmentType: json['employment_type'] as String?,
      jobModes: List<String>.from(json['job_modes'] ?? const []),
      salaryIsNegotiable: json['salary_is_negotiable'] as bool?,
      categories:
          (json['category_ids'] as List? ??
                  json['categories'] as List? ??
                  const [])
              .map((value) => value.toString())
              .toList(),
    );
  }
}

class TagModel {
  final String? id;
  final String? name;

  TagModel({this.id, this.name});

  TagModel copyWith({String? id, String? name}) {
    return TagModel(id: id ?? this.id, name: name ?? this.name);
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(id: json['id']?.toString(), name: json['name'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
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
