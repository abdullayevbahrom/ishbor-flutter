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
  final bool? isFavorite;
  final int? clickCount;

  Vacancy({
    id,
    status,
    title,
    createdAt,
    description,
    shortDescription,
    customer,
    phoneNumber,
    performer,
    viewCount,
    city,
    moderatorNote,
    categories,
    titleUz,
    titleRu,
    descriptionUz,
    descriptionRu,
    shortDescriptionUz,
    shortDescriptionRu,
    this.negotiable,
    images,
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
    this.isFavorite,
    this.clickCount,
  }) : super(
         id: id,
         status: status,
         title: title,
         createdAt: createdAt,
         categories: categories,
         customer: customer,
         phoneNumber: phoneNumber,
         viewCount: viewCount,
         city: city,
         description: description,
         images: images,
         moderatorNote: moderatorNote,
         negotiable: negotiable,
         performer: performer,
         shortDescription: shortDescription,
         descriptionRu: descriptionRu,
         descriptionUz: descriptionUz,
         shortDescriptionRu: shortDescriptionRu,
         shortDescriptionUz: shortDescriptionUz,
         titleRu: titleRu,
         titleUz: titleUz,
       );

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
  }) {
    return Vacancy(
      id: id,
      status: status??this.status,
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
      images: images??this.images,
      isNeedLiftUp: isNeedLiftUp ?? this.isNeedLiftUp,
      titleUz: titleUz ?? this.titleUz,
      titleRu: titleRu ?? this.titleRu,
      descriptionUz: descriptionUz ?? this.descriptionUz,
      descriptionRu: descriptionRu ?? this.descriptionRu,
      shortDescriptionUz: shortDescriptionUz ?? this.shortDescriptionUz,
      shortDescriptionRu: shortDescriptionRu ?? this.shortDescriptionRu,
      clickCount: countClick ?? this.clickCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    status,
    title,
    createdAt,
    description,
    shortDescription,
    customer,
    phoneNumber,
    performer,
    viewCount,
    city,
    moderatorNote,
    categories,
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
    images,
    isNeedLiftUp,
    telegram,
    phoneNumber1,
    phoneNumber2,
    phoneNumber3,
    liftedUpAt,
    updatedAt,
    isFavorite
  ];

  static Vacancy fromMap(Map<String, dynamic> data) {
    return Vacancy(
      id: data['id'],
      status: data['status'],
      title: data['title'],
      createdAt: DateTime.tryParse(data['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(data['updated_at'] ?? ''),
      liftedUpAt: DateTime.tryParse(data['lifted_up_at'] ?? ''),
      description: data['description'] ?? '',
      shortDescription: data['short_description'] ?? '',
      customer:
          data['customer'] != null ? User.fromMap(data['customer']) : null,
      phoneNumber: data['phone_number'],
      phoneNumber1: data['phone_number1'],
      phoneNumber2: data['phone_number2'],
      phoneNumber3: data['phone_number3'],
      telegram: data['telegram'],
      performer:
          data['performer'] != null ? User.fromMap(data['performer']) : null,
      viewCount: data['view_count'],
      city: data['city'],
      moderatorNote: data['moderator_note'],

      categories:
          (data['categories'] as List?)
              ?.map((cat) => CategoryModel.fromMap(cat))
              .toList() ??
          [],

      skills: (data['skills'] as List?)?.cast<String>() ?? [],

      salaryMin: (data['salary_min'] as num?)?.toDouble(),
      salaryMax: (data['salary_max'] as num?)?.toDouble(),
      salaryCurrency: data['salary_currency'],
      negotiable: data['negotiable'],
      companyName: data['company_name'],
      companyDescription: data['company_description'],
      address:
          data['address'] != null
              ? AddressModel.fromJson(data['address'])
              : null,

      partialJobOpportunity: data['partial_job_opportunity'] ?? false,
      employmentType: data['employment_type'],
      jobModes: (data['job_modes'] as List?)?.cast<String>() ?? [],
      whoCanRespond: (data['who_can_respond'] as List?)?.cast<String>() ?? [],

      images:
          (data['images'] as List?)
              ?.map((img) => AppImage.fromMap(Map.from(img)))
              .toList() ??
          [],

      isNeedLiftUp: data['is_need_lift_up'] ?? false,
      titleRu: data['title_ru'],
      titleUz: data['title_uz'],
      shortDescriptionUz: data['short_description_uz'],
      shortDescriptionRu: data['short_description_ru'],
      descriptionUz: data['description_uz'],
      descriptionRu: data['description_ru'],
      isFavorite: data['is_favorite'],
      clickCount: data['click_count'],
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
      currentPageNumber: map['current_page_number'] ?? 1,
      numItemsPerPage: map['num_items_per_page'] ?? 10,
      totalCount: map['total_count'] ?? 0,
      items:
          List<Map<String, dynamic>>.from(
            map['items'] ?? [],
          ).map((e) => Vacancy.fromMap(e)).toList(),
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
