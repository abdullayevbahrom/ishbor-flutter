import '../../../../models/address.dart';
import '../../../../models/image.dart';
import '../../../../models/user.dart';
import '../../../../core/helpers/date_time_parser.dart';
import '../../../../models/api_model_utils.dart';
import '../../../common/data/models/category.dart';

class PaginatedTaskListResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<TaskModel> items;
  final int totalCount;
  final PaginatorOptions paginatorOptions;
  final dynamic customParameters;
  final String route;

  PaginatedTaskListResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
    required this.paginatorOptions,
    required this.customParameters,
    required this.route,
  });

  factory PaginatedTaskListResponse.fromJson(Map<String, dynamic> json) {
    return PaginatedTaskListResponse(
      currentPageNumber: json['current_page_number'],
      numItemsPerPage: json['num_items_per_page'],
      items: List<TaskModel>.from(
        json['items'].map((x) => TaskModel.fromJson(x)),
      ),
      totalCount: json['total_count'],
      paginatorOptions: PaginatorOptions.fromJson(json['paginator_options']),
      customParameters: json['custom_parameters'],
      route: json['route'],
    );
  }

  PaginatedTaskListResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<TaskModel>? items,
    int? totalCount,
    PaginatorOptions? paginatorOptions,
    dynamic customParameters,
    String? route,
  }) {
    return PaginatedTaskListResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      paginatorOptions: paginatorOptions ?? this.paginatorOptions,
      customParameters: customParameters ?? this.customParameters,
      route: route ?? this.route,
    );
  }
}

class TaskModel {
  final String id;
  final String status;
  final String title;
  final String? description;
  final String? shortDescription;
  final User customer;
  final String? phoneNumber;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final String? phoneNumber4;
  final User? performer;
  final int viewCount;
  final String? city;
  final String? moderatorNote;
  final DateTime liftedUpAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? price;
  final List<CategoryModel> categories;
  final List<AddressModel> addresses;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final List<String> paymentMethods;
  final bool negotiable;
  final bool remote;
  final bool secureDeal;
  final bool compensation;
  final List<AppImage> images;
  final bool isNeedLiftUp;
  final String? titleUz;
  final String? titleRu;
  final String? descriptionUz;
  final String? descriptionRu;
  final String? shortDescriptionUz;
  final String? shortDescriptionRu;
  final bool? isFavorite;
  final int? countClick;
  final bool? hasUserRequest;

  TaskModel({
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
    this.phoneNumber4,
    this.titleUz,
    this.titleRu,
    this.descriptionUz,
    this.descriptionRu,
    this.shortDescriptionUz,
    this.shortDescriptionRu,
    required this.id,
    required this.status,
    required this.title,
    required this.description,
    required this.shortDescription,
    required this.customer,
    this.phoneNumber,
    this.performer,
    required this.viewCount,
    this.city,
    this.moderatorNote,
    required this.liftedUpAt,
    required this.createdAt,
    required this.updatedAt,
    required this.price,
    required this.categories,
    required this.addresses,
    required this.startsAt,
    required this.expiresAt,
    required this.paymentMethods,
    required this.negotiable,
    required this.remote,
    required this.secureDeal,
    required this.compensation,
    required this.images,
    required this.isNeedLiftUp,
    this.isFavorite,
    this.countClick,
    this.hasUserRequest,
  });

  TaskModel copyWith({
    bool clearPerformer = false,
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    String? phoneNumber4,
    String? id,
    String? status,
    String? title,
    String? description,
    String? shortDescription,
    User? customer,
    String? phoneNumber,
    User? performer,
    int? viewCount,
    String? city,
    String? moderatorNote,
    DateTime? liftedUpAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? price,
    List<CategoryModel>? categories,
    List<AddressModel>? addresses,
    DateTime? startsAt,
    DateTime? expiresAt,
    List<String>? paymentMethods,
    bool? negotiable,
    bool? remote,
    bool? secureDeal,
    bool? compensation,
    List<AppImage>? images,
    bool? isNeedLiftUp,
    String? titleUz,
    String? titleRu,
    String? descriptionUz,
    String? descriptionRu,
    String? shortDescriptionUz,
    String? shortDescriptionRu,
    bool? isFavorite,
    int? countClick,
    bool? hasUserRequest,
  }) {
    return TaskModel(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      customer: customer ?? this.customer,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      performer: clearPerformer ? null : performer ?? this.performer,
      viewCount: viewCount ?? this.viewCount,
      city: city ?? this.city,
      moderatorNote: moderatorNote ?? this.moderatorNote,
      liftedUpAt: liftedUpAt ?? this.liftedUpAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      price: price ?? this.price,
      categories: categories ?? this.categories,
      addresses: addresses ?? this.addresses,
      startsAt: startsAt ?? this.startsAt,
      expiresAt: expiresAt ?? this.expiresAt,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      negotiable: negotiable ?? this.negotiable,
      remote: remote ?? this.remote,
      secureDeal: secureDeal ?? this.secureDeal,
      compensation: compensation ?? this.compensation,
      images: images ?? this.images,
      isNeedLiftUp: isNeedLiftUp ?? this.isNeedLiftUp,
      titleUz: titleUz ?? this.titleUz,
      titleRu: titleRu ?? this.titleRu,
      descriptionUz: descriptionUz ?? this.descriptionUz,
      descriptionRu: descriptionRu ?? this.descriptionRu,
      shortDescriptionUz: shortDescriptionUz ?? this.shortDescriptionUz,
      shortDescriptionRu: shortDescriptionRu ?? this.shortDescriptionRu,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      phoneNumber4: phoneNumber4 ?? this.phoneNumber4,
      isFavorite: isFavorite ?? this.isFavorite,
      countClick: countClick ?? this.countClick,
      hasUserRequest: hasUserRequest ?? this.hasUserRequest,
    );
  }

  factory TaskModel.fromJson(dynamic source) {
    final json = unwrapData(source);

    return TaskModel(
      id: stringValue(json['id']) ?? '',
      status: stringValue(json['status']) ?? '',
      title: _localizedValue(json['title']) ?? '',
      titleUz:
          _localizedLocaleValue(json['title'], 'uz') ??
          stringValue(json['title_uz']),
      titleRu:
          _localizedLocaleValue(json['title'], 'ru') ??
          stringValue(json['title_ru']),
      description: _localizedValue(json['description']),
      descriptionUz:
          _localizedLocaleValue(json['description'], 'uz') ??
          stringValue(json['description_uz']),
      descriptionRu:
          _localizedLocaleValue(json['description'], 'ru') ??
          stringValue(json['description_ru']),
      shortDescription: _localizedValue(json['short_description']),
      shortDescriptionUz:
          _localizedLocaleValue(json['short_description'], 'uz') ??
          stringValue(json['short_description_uz']),
      shortDescriptionRu:
          _localizedLocaleValue(json['short_description'], 'ru') ??
          stringValue(json['short_description_ru']),
      customer:
          json['customer'] != null
              ? User.fromMap(json['customer'])
              : (json['user'] != null
                  ? User.fromMap(json['user'])
                  : User.fromMap(json['owner'] ?? {})),
      phoneNumber: stringValue(json['phone_number']),
      phoneNumber1: stringValue(json['phone_number1']),
      phoneNumber2: stringValue(json['phone_number2']),
      phoneNumber3: stringValue(json['phone_number3']),
      phoneNumber4: stringValue(json['phone_number4']),
      performer:
          json['performer'] != null ? User.fromMap(json['performer']) : null,
      viewCount: intValue(json['view_count']) ?? 0,
      city: stringValue(json['city']),
      moderatorNote: stringValue(json['moderator_note']),
      liftedUpAt: parseRequiredDateTime(json['lifted_up_at']),
      createdAt: parseRequiredDateTime(json['created_at']),
      updatedAt: parseRequiredDateTime(json['updated_at']),
      price: doubleValue(json['price']),
      categories: mappedList(json['categories'], CategoryModel.fromMap),
      addresses: mappedList(json['addresses'], AddressModel.fromJson),
      startsAt: parseNullableDateTime(json['starts_at']),
      expiresAt: parseNullableDateTime(json['expires_at']),
      paymentMethods: stringList(json['payment_methods']) ?? const [],
      negotiable: boolValue(json['negotiable']) ?? false,
      remote: boolValue(json['remote']) ?? false,
      secureDeal: boolValue(json['secure_deal']) ?? false,
      compensation: boolValue(json['compensation']) ?? false,
      images: mappedList(json['images'], AppImage.fromJson),
      isNeedLiftUp: boolValue(json['is_need_lift_up']) ?? false,
      countClick: intValue(json['click_count']),
      isFavorite: boolValue(json['is_favorite']),
      hasUserRequest: boolValue(json['has_user_request']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'title': title,
      'title_uz': titleUz,
      'title_ru': titleRu,
      'description': description,
      'description_uz': descriptionUz,
      'description_ru': descriptionRu,
      'short_description': shortDescription,
      'short_description_uz': shortDescriptionUz,
      'short_description_ru': shortDescriptionRu,
      'phone_number': phoneNumber,
      'view_count': viewCount,
      'city': city,
      'moderator_note': moderatorNote,
      'lifted_up_at': liftedUpAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'price': price,
      'starts_at': startsAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'payment_methods': paymentMethods,
      'negotiable': negotiable,
      'remote': remote,
      'secure_deal': secureDeal,
      'compensation': compensation,
      'is_need_lift_up': isNeedLiftUp,
      "click_count": countClick,
      "is_favorite": isFavorite,
    };
  }
}

String? _localizedValue(dynamic value) {
  if (value is String) {
    return value;
  }

  if (value is Map) {
    final map = asMap(value);
    return stringValue(map['uz'] ?? map['ru'] ?? map['en']);
  }

  return stringValue(value);
}

String? _localizedLocaleValue(dynamic value, String locale) {
  if (value is Map) {
    return stringValue(asMap(value)[locale]);
  }

  return null;
}

class PaginatorOptions {
  final String pageParameterName;
  final String sortFieldParameterName;
  final String sortDirectionParameterName;
  final String filterFieldParameterName;
  final String filterValueParameterName;
  final bool distinct;
  final String pageOutOfRange;
  final int defaultLimit;

  PaginatorOptions({
    required this.pageParameterName,
    required this.sortFieldParameterName,
    required this.sortDirectionParameterName,
    required this.filterFieldParameterName,
    required this.filterValueParameterName,
    required this.distinct,
    required this.pageOutOfRange,
    required this.defaultLimit,
  });

  factory PaginatorOptions.fromJson(Map<String, dynamic> json) {
    return PaginatorOptions(
      pageParameterName: json['pageParameterName'],
      sortFieldParameterName: json['sortFieldParameterName'],
      sortDirectionParameterName: json['sortDirectionParameterName'],
      filterFieldParameterName: json['filterFieldParameterName'],
      filterValueParameterName: json['filterValueParameterName'],
      distinct: json['distinct'],
      pageOutOfRange: json['pageOutOfRange'],
      defaultLimit: json['defaultLimit'],
    );
  }
}

class CustomParameters {
  final bool sorted;

  CustomParameters({required this.sorted});

  factory CustomParameters.fromJson(Map<String, dynamic> json) {
    return CustomParameters(sorted: json['sorted']);
  }
}
