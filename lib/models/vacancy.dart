import 'package:top_jobs/models/ad_customer.dart';
import 'package:top_jobs/models/api_model_utils.dart';
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

  const Vacancy({
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
    super.negotiable,
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
    final currentIsNeedLiftUp = this.isNeedLiftUp;
    final currentClickCount = clickCount;
    final currentIsFavorite = this.isFavorite;
    final currentHasUserRequest = this.hasUserRequest;
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
      images: images,
      isNeedLiftUp: isNeedLiftUp ?? currentIsNeedLiftUp,
      clickCount: countClick ?? currentClickCount,
      isFavorite: isFavorite ?? currentIsFavorite,
      hasUserRequest: hasUserRequest ?? currentHasUserRequest,
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
    final payload = asMap(unwrapData(data));

    return Vacancy(
      id: stringValue(payload['id']) ?? '',
      status: stringValue(payload['status']) ?? '',
      title: LocalizedText.fromJson(payload['title']),
      createdAt: dateTimeValue(payload['created_at']) ?? DateTime.now().toUtc(),
      updatedAt: dateTimeValue(payload['updated_at']),
      liftedUpAt: dateTimeValue(payload['lifted_up_at']),
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
      phoneNumber: stringValue(payload['phone_number']),
      phoneNumber1: stringValue(payload['phone_number1']),
      phoneNumber2: stringValue(payload['phone_number2']),
      phoneNumber3: stringValue(payload['phone_number3']),
      telegram: stringValue(payload['telegram']),
      performer:
          payload['performer'] != null
              ? User.fromMap(payload['performer'])
              : null,
      viewCount: intValue(payload['view_count']),
      city: stringValue(payload['city']),
      moderatorNote: stringValue(payload['moderator_note']),
      categories: mappedList(payload['categories'], CategoryModel.fromMap),
      skills: stringList(payload['skills']),
      salaryMin: doubleValue(payload['salary_min']),
      salaryMax: doubleValue(payload['salary_max']),
      salaryCurrency: stringValue(payload['salary_currency']),
      negotiable: boolValue(payload['negotiable']),
      companyName: stringValue(payload['company_name']),
      companyDescription: stringValue(payload['company_description']),
      address:
          payload['address'] != null
              ? AddressModel.fromJson(payload['address'])
              : null,
      partialJobOpportunity:
          boolValue(payload['partial_job_opportunity']) ?? false,
      employmentType: stringValue(payload['employment_type']),
      jobModes: stringList(payload['job_modes']),
      whoCanRespond: stringList(payload['who_can_respond']),
      images: mappedList(payload['images'], AppImage.fromJson),
      isNeedLiftUp: boolValue(payload['is_need_lift_up']) ?? false,
      isFavorite: boolValue(payload['is_favorite']),
      hasUserRequest: boolValue(payload['has_user_request']),
      clickCount: intValue(payload['click_count']),
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
    final payload = asMap(unwrapData(map));

    return VacancyPaginationResponse(
      currentPageNumber: intValue(payload['current_page_number']) ?? 1,
      numItemsPerPage: intValue(payload['num_items_per_page']) ?? 10,
      totalCount: intValue(payload['total_count']) ?? 0,
      items: mappedList(
        payload['items'],
        (item) => Vacancy.fromMap(asMap(item)),
      ),
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
