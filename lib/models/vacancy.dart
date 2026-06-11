import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/localized_text.dart';
import 'package:top_jobs/models/user.dart';

import '../feature/common/data/models/category.dart';
import 'ad.dart';
import 'address.dart';
import 'image.dart';

class Vacancy extends Ad {
  final List<String>? skills;
  final double? salaryMin;
  final double? salaryMax;
  final String? salaryCurrency;
  final bool? negotiable;
  final String? companyName;
  final String? companyDescription;
  final AddressModel? address;
  final bool partialJobOpportunity;
  final String? employmentType;
  final List<String>? jobModes;
  final List<String>? whoCanRespond;
  final bool isNeedLiftUp;
  final String? telegram;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final DateTime? liftedUpAt;
  final DateTime? updatedAt;
  final int? clickCount;

  Vacancy({
    required super.id,
    required super.status,
    required super.title,
    required super.createdAt,
    super.description,
    super.shortDescription,
    required super.customer,
    super.phoneNumber,
    super.performer,
    super.viewCount,
    super.city,
    super.moderatorNote,
    required super.categories,
    super.images,
    super.isFavorite,
    super.hasUserRequest,
    this.negotiable,
    this.skills,
    this.salaryMin,
    this.salaryMax,
    this.salaryCurrency,
    this.companyName,
    this.companyDescription,
    this.address,
    this.partialJobOpportunity = false,
    this.employmentType,
    this.jobModes,
    this.whoCanRespond,
    required this.isNeedLiftUp,
    this.telegram,
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
    this.liftedUpAt,
    this.updatedAt,
    this.clickCount,
  });

  Vacancy copyWith({
    String? status,
    List<String>? skills,
    double? salaryMin,
    double? salaryMax,
    String? salaryCurrency,
    bool? negotiable,
    String? companyName,
    String? companyDescription,
    AddressModel? address,
    bool? partialJobOpportunity,
    String? employmentType,
    List<String>? jobModes,
    List<String>? whoCanRespond,
    bool? isNeedLiftUp,
    String? telegram,
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    DateTime? liftedUpAt,
    DateTime? updatedAt,
    bool? isFavorite,
    int? countClick,
    bool? hasUserRequest,
  }) {
    return Vacancy(
      id: id,
      status: status ?? this.status,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      liftedUpAt: liftedUpAt ?? this.liftedUpAt,
      description: description,
      shortDescription: shortDescription,
      customer: customer,
      phoneNumber: phoneNumber,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      telegram: telegram ?? this.telegram,
      performer: performer,
      viewCount: viewCount,
      city: city,
      moderatorNote: moderatorNote,
      categories: categories,
      skills: skills ?? this.skills,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      salaryCurrency: salaryCurrency ?? this.salaryCurrency,
      negotiable: negotiable ?? this.negotiable,
      companyName: companyName ?? this.companyName,
      companyDescription: companyDescription ?? this.companyDescription,
      address: address ?? this.address,
      partialJobOpportunity:
          partialJobOpportunity ?? this.partialJobOpportunity,
      employmentType: employmentType ?? this.employmentType,
      jobModes: jobModes ?? this.jobModes,
      whoCanRespond: whoCanRespond ?? this.whoCanRespond,
      images: images ?? this.images,
      isNeedLiftUp: isNeedLiftUp ?? this.isNeedLiftUp,
      clickCount: countClick ?? this.clickCount,
      isFavorite: isFavorite ?? this.isFavorite,
      hasUserRequest: hasUserRequest ?? this.hasUserRequest,
    );
  }

  @override
  List<Object?> get props => [
    ...super.props,
    skills,
    salaryMin,
    salaryMax,
    salaryCurrency,
    negotiable,
    companyName,
    companyDescription,
    address,
    partialJobOpportunity,
    employmentType,
    jobModes,
    whoCanRespond,
    isNeedLiftUp,
    telegram,
    phoneNumber1,
    phoneNumber2,
    phoneNumber3,
    liftedUpAt,
    updatedAt,
    clickCount,
  ];

  static Vacancy fromMap(Map<String, dynamic> data) {
    final payload = _asMap(_unwrapData(data));

    return Vacancy(
      id: _asString(payload['id']) ?? '',
      status: _asString(payload['status']) ?? '',
      title: LocalizedText.fromJson(payload['title']),
      createdAt: _asDateTime(payload['created_at']) ?? DateTime.now().toUtc(),
      updatedAt: _asDateTime(payload['updated_at']),
      liftedUpAt: _asDateTime(payload['lifted_up_at']),
      description:
          payload['description'] != null
              ? LocalizedText.fromJson(payload['description'])
              : null,
      shortDescription:
          payload['short_description'] != null
              ? LocalizedText.fromJson(payload['short_description'])
              : null,
      customer: AdCustomer.fromJson(
        payload['customer'] ?? payload['user'] ?? payload['owner'],
      ),
      phoneNumber: _asString(payload['phone_number']),
      phoneNumber1: _asString(payload['phone_number1']),
      phoneNumber2: _asString(payload['phone_number2']),
      phoneNumber3: _asString(payload['phone_number3']),
      telegram: _asString(payload['telegram']),
      performer:
          payload['performer'] != null
              ? User.fromMap(_asMap(payload['performer']))
              : null,
      viewCount: _asInt(payload['view_count']),
      city: _asString(payload['city']),
      moderatorNote: _asString(payload['moderator_note']),
      categories: _asCategoryList(payload['categories']),
      skills: _asStringList(payload['skills']),
      salaryMin: _asDouble(payload['salary_min']),
      salaryMax: _asDouble(payload['salary_max']),
      salaryCurrency: _asString(payload['salary_currency']),
      negotiable: _asBool(payload['negotiable']),
      companyName: _asString(payload['company_name']),
      companyDescription: _asString(payload['company_description']),
      address:
          payload['address'] != null
              ? AddressModel.fromJson(_asMap(payload['address']))
              : null,
      partialJobOpportunity:
          _asBool(payload['partial_job_opportunity']) ?? false,
      employmentType: _asString(payload['employment_type']),
      jobModes: _asStringList(payload['job_modes']),
      whoCanRespond: _asStringList(payload['who_can_respond']),
      images: _asImageList(payload['images']),
      isNeedLiftUp: _asBool(payload['is_need_lift_up']) ?? false,
      isFavorite: _asBool(payload['is_favorite']),
      hasUserRequest: _asBool(payload['has_user_request']),
      clickCount: _asInt(payload['click_count']),
    );
  }
}

class VacancyPaginationResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final int totalCount;
  final List<Vacancy> items;

  VacancyPaginationResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.totalCount,
    required this.items,
  });

  factory VacancyPaginationResponse.fromMap(Map<String, dynamic> map) {
    final payload = _asMap(_unwrapData(map));

    return VacancyPaginationResponse(
      currentPageNumber: _asInt(payload['current_page_number']) ?? 1,
      numItemsPerPage: _asInt(payload['num_items_per_page']) ?? 10,
      totalCount: _asInt(payload['total_count']) ?? 0,
      items: _asMapList(
        payload['items'],
      ).map(Vacancy.fromMap).toList(growable: false),
    );
  }

  VacancyPaginationResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    int? totalCount,
    List<Vacancy>? items,
  }) {
    return VacancyPaginationResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      totalCount: totalCount ?? this.totalCount,
      items: items ?? this.items,
    );
  }
}

Map<String, dynamic> _unwrapData(Map<String, dynamic> data) {
  final payload = data['data'];

  if (payload is Map<String, dynamic>) {
    return Map<String, dynamic>.from(payload);
  }

  if (payload is Map) {
    return Map<String, dynamic>.fromEntries(
      payload.entries.map(
        (entry) => MapEntry(entry.key.toString(), entry.value),
      ),
    );
  }

  return data;
}

Map<String, dynamic> _asMap(dynamic value) {
  if (value is Map<String, dynamic>) {
    return Map<String, dynamic>.from(value);
  }

  if (value is Map) {
    return Map<String, dynamic>.fromEntries(
      value.entries.map((entry) => MapEntry(entry.key.toString(), entry.value)),
    );
  }

  return <String, dynamic>{};
}

List<Map<String, dynamic>> _asMapList(dynamic value) {
  if (value is! List) {
    return const <Map<String, dynamic>>[];
  }

  return value.whereType<Map>().map(_asMap).toList(growable: false);
}

List<String>? _asStringList(dynamic value) {
  if (value is! List) {
    return null;
  }

  return value.map((item) => item.toString()).toList(growable: false);
}

List<CategoryModel> _asCategoryList(dynamic value) {
  if (value is! List) {
    return const <CategoryModel>[];
  }

  return value
      .whereType<Map>()
      .map((item) => CategoryModel.fromMap(_asMap(item)))
      .toList(growable: false);
}

List<AppImage> _asImageList(dynamic value) {
  if (value is! List) {
    return const <AppImage>[];
  }

  return value
      .whereType<Map>()
      .map((item) => AppImage.fromMap(_asMap(item)))
      .toList(growable: false);
}

String? _asString(dynamic value) {
  if (value == null) {
    return null;
  }

  return value.toString();
}

int? _asInt(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString());
}

double? _asDouble(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is double) {
    return value;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString());
}

bool? _asBool(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is bool) {
    return value;
  }

  if (value is num) {
    return value != 0;
  }

  final normalized = value.toString().toLowerCase().trim();
  if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
    return true;
  }
  if (normalized == 'false' || normalized == '0' || normalized == 'no') {
    return false;
  }

  return null;
}

DateTime? _asDateTime(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is DateTime) {
    return value;
  }

  return DateTime.tryParse(value.toString());
}
