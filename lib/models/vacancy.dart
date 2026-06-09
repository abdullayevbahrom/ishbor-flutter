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
      partialJobOpportunity: partialJobOpportunity ?? this.partialJobOpportunity,
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
    return Vacancy(
      id: data['id']?.toString() ?? '',
      status: data['status']?.toString() ?? '',
      title: LocalizedText.fromJson(data['title']),
      createdAt: DateTime.tryParse(data['created_at']?.toString() ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['updated_at']?.toString() ?? ''),
      liftedUpAt: DateTime.tryParse(data['lifted_up_at']?.toString() ?? ''),
      description: data['description'] != null ? LocalizedText.fromJson(data['description']) : null,
      shortDescription: data['short_description'] != null ? LocalizedText.fromJson(data['short_description']) : null,
      customer: AdCustomer.fromJson(data['customer'] ?? data['user'] ?? data['owner']),
      phoneNumber: data['phone_number']?.toString(),
      phoneNumber1: data['phone_number1']?.toString(),
      phoneNumber2: data['phone_number2']?.toString(),
      phoneNumber3: data['phone_number3']?.toString(),
      telegram: data['telegram']?.toString(),
      performer: data['performer'] != null ? User.fromMap(data['performer']) : null,
      viewCount: data['view_count'] is num ? (data['view_count'] as num).toInt() : null,
      city: data['city']?.toString(),
      moderatorNote: data['moderator_note']?.toString(),
      categories: (data['categories'] as List?)?.map((cat) => CategoryModel.fromMap(cat)).toList() ?? [],
      skills: (data['skills'] as List?)?.map((e) => e.toString()).toList(),
      salaryMin: (data['salary_min'] as num?)?.toDouble(),
      salaryMax: (data['salary_max'] as num?)?.toDouble(),
      salaryCurrency: data['salary_currency']?.toString(),
      negotiable: data['negotiable'] == true,
      companyName: data['company_name']?.toString(),
      companyDescription: data['company_description']?.toString(),
      address: data['address'] != null ? AddressModel.fromJson(data['address']) : null,
      partialJobOpportunity: data['partial_job_opportunity'] == true,
      employmentType: data['employment_type']?.toString(),
      jobModes: (data['job_modes'] as List?)?.map((e) => e.toString()).toList(),
      whoCanRespond: (data['who_can_respond'] as List?)?.map((e) => e.toString()).toList(),
      images: (data['images'] as List?)?.map((img) => AppImage.fromMap(Map.from(img))).toList(),
      isNeedLiftUp: data['is_need_lift_up'] == true,
      isFavorite: data['is_favorite'] == true,
      hasUserRequest: data['has_user_request'] == true,
      clickCount: data['click_count'] is num ? (data['click_count'] as num).toInt() : null,
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
    return VacancyPaginationResponse(
      currentPageNumber: map['current_page_number'] is num ? (map['current_page_number'] as num).toInt() : 1,
      numItemsPerPage: map['num_items_per_page'] is num ? (map['num_items_per_page'] as num).toInt() : 10,
      totalCount: map['total_count'] is num ? (map['total_count'] as num).toInt() : 0,
      items: (map['items'] as List?)?.map((e) => Vacancy.fromMap(Map<String, dynamic>.from(e))).toList() ?? [],
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
