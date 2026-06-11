import 'package:flutter/foundation.dart';
import '../../../../models/ad_pricable.dart';
import '../../../../models/ad_customer.dart';
import '../../../../models/address.dart';
import '../../../../core/helpers/date_time_parser.dart';
import '../../../../models/api_model_utils.dart';
import '../../../../models/image.dart';
import '../../../../models/user.dart';
import '../../../common/data/models/category.dart';
import '../../../../models/localized_text.dart';

class PaginatedServiceResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<ServiceModel> items;
  final int totalCount;
  final PaginatorOptions paginatorOptions;
  final dynamic customParameters;
  final String route;
  final dynamic params;
  final int pageRange;
  final int? pageLimit;
  final String template;
  final String sortableTemplate;
  final String filtrationTemplate;

  PaginatedServiceResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
    required this.paginatorOptions,
    required this.customParameters,
    required this.route,
    required this.params,
    required this.pageRange,
    required this.pageLimit,
    required this.template,
    required this.sortableTemplate,
    required this.filtrationTemplate,
  });

  factory PaginatedServiceResponse.fromMap(Map<String, dynamic> json) {
    final payload = asMap(unwrapData(json));
    final items = mappedList(payload['items'], ServiceModel.fromMap);
    final currentPageNumber =
        intValue(
          payload['current_page_number'] ?? payload['currentPageNumber'],
        ) ??
        1;
    final numItemsPerPage =
        intValue(payload['num_items_per_page'] ?? payload['numItemsPerPage']) ??
        items.length;
    final totalCount =
        intValue(payload['total_count'] ?? payload['totalCount']) ??
        items.length;

    if (kDebugMode &&
        (payload['paginator_options'] == null ||
            payload['custom_parameters'] == null)) {
      debugPrint(
        '[FIX] PaginatedServiceResponse.fromMap normalized minimal list payload: items=${items.length}, totalCount=$totalCount',
      );
    }

    return PaginatedServiceResponse(
      currentPageNumber: currentPageNumber,
      numItemsPerPage: numItemsPerPage,
      items: items,
      totalCount: totalCount,
      paginatorOptions:
          payload['paginator_options'] != null
              ? PaginatorOptions.fromMap(asMap(payload['paginator_options']))
              : PaginatorOptions.empty(),
      customParameters:
          payload['custom_parameters'] != null
              ? CustomParameters.fromMap(asMap(payload['custom_parameters']))
              : CustomParameters.empty(),
      route: stringValue(payload['route']) ?? '',
      params: payload['params'],
      pageRange: intValue(payload['page_range'] ?? payload['pageRange']) ?? 1,
      pageLimit: intValue(payload['page_limit'] ?? payload['pageLimit']),
      template: stringValue(payload['template']) ?? '',
      sortableTemplate:
          stringValue(
            payload['sortable_template'] ?? payload['sortableTemplate'],
          ) ??
          '',
      filtrationTemplate:
          stringValue(
            payload['filtration_template'] ?? payload['filtrationTemplate'],
          ) ??
          '',
    );
  }

  PaginatedServiceResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<ServiceModel>? items,
    int? totalCount,
    PaginatorOptions? paginatorOptions,
    dynamic customParameters,
    String? route,
    dynamic params,
    int? pageRange,
    int? pageLimit,
    String? template,
    String? sortableTemplate,
    String? filtrationTemplate,
  }) {
    return PaginatedServiceResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
      paginatorOptions: paginatorOptions ?? this.paginatorOptions,
      customParameters: customParameters ?? this.customParameters,
      route: route ?? this.route,
      params: params ?? this.params,
      pageRange: pageRange ?? this.pageRange,
      pageLimit: pageLimit ?? this.pageLimit,
      template: template ?? this.template,
      sortableTemplate: sortableTemplate ?? this.sortableTemplate,
      filtrationTemplate: filtrationTemplate ?? this.filtrationTemplate,
    );
  }
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

  factory PaginatorOptions.fromMap(Map<String, dynamic> json) {
    return PaginatorOptions(
      pageParameterName:
          stringValue(
            json['pageParameterName'] ?? json['page_parameter_name'],
          ) ??
          'page',
      sortFieldParameterName:
          stringValue(
            json['sortFieldParameterName'] ?? json['sort_field_parameter_name'],
          ) ??
          '',
      sortDirectionParameterName:
          stringValue(
            json['sortDirectionParameterName'] ??
                json['sort_direction_parameter_name'],
          ) ??
          '',
      filterFieldParameterName:
          stringValue(
            json['filterFieldParameterName'] ??
                json['filter_field_parameter_name'],
          ) ??
          '',
      filterValueParameterName:
          stringValue(
            json['filterValueParameterName'] ??
                json['filter_value_parameter_name'],
          ) ??
          '',
      distinct: boolValue(json['distinct']) ?? false,
      pageOutOfRange:
          stringValue(json['pageOutOfRange'] ?? json['page_out_of_range']) ??
          '',
      defaultLimit:
          intValue(json['defaultLimit'] ?? json['default_limit']) ?? 0,
    );
  }

  factory PaginatorOptions.empty() {
    return PaginatorOptions(
      pageParameterName: 'page',
      sortFieldParameterName: '',
      sortDirectionParameterName: '',
      filterFieldParameterName: '',
      filterValueParameterName: '',
      distinct: false,
      pageOutOfRange: '',
      defaultLimit: 0,
    );
  }
}

class CustomParameters {
  final bool sorted;

  CustomParameters({required this.sorted});

  factory CustomParameters.fromMap(Map<String, dynamic> json) {
    return CustomParameters(sorted: boolValue(json['sorted']) ?? false);
  }

  factory CustomParameters.empty() {
    return CustomParameters(sorted: false);
  }
}

class ServiceModel extends AdPricable {
  final AddressModel? address;
  final bool? isNeedLiftUp;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final int? clickCount;

  ServiceModel({
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
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
    super.negotiable,
    super.isFavorite,
    this.address,
    this.isNeedLiftUp,
    this.clickCount,
    double? price,
  }) : super(
         price: price,
       );

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
    images,
    address,
    isFavorite,
  ];

  static ServiceModel fromMap(dynamic source) {
    final data = unwrapData(source);

    return ServiceModel(
      id: stringValue(data['id']) ?? '',
      status: stringValue(data['status']) ?? '',
      title: LocalizedText.fromJson(data['title']),
      createdAt: parseRequiredDateTime(data['created_at']),
      description:
          data['description'] != null
              ? LocalizedText.fromJson(data['description'])
              : null,
      shortDescription:
          data['short_description'] != null
              ? LocalizedText.fromJson(data['short_description'])
              : null,
      customer:
          data['customer'] != null
              ? AdCustomer.fromJson(data['customer'])
              : (data['user'] != null
                  ? AdCustomer.fromJson(data['user'])
                  : AdCustomer.fromJson(data['owner'] ?? {})),
      phoneNumber: stringValue(data['phone_number']),
      performer:
          data['performer'] != null ? User.fromMap(data['performer']) : null,
      viewCount: intValue(data['view_count']),
      city: stringValue(data['city']),
      moderatorNote: stringValue(data['moderator_note']),
      categories: mappedList(data['categories'], CategoryModel.fromMap),
      address:
          data['address'] != null
              ? AddressModel.fromJson(data['address'])
              : null,
      images: mappedList(data['images'], AppImage.fromJson),
      negotiable: boolValue(data['negotiable']),
      price: doubleValue(data['price']),
      isNeedLiftUp: boolValue(data['is_need_lift_up']),
      phoneNumber1: stringValue(data['phone_number1']),
      phoneNumber2: stringValue(data['phone_number2']),
      phoneNumber3: stringValue(data['phone_number3']),
      clickCount: intValue(data['click_count']),
      isFavorite: boolValue(data['is_favorite']),
    );
  }

  ServiceModel copyWith({
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    String? id,
    String? status,
    LocalizedText? title,
    DateTime? createdAt,
    LocalizedText? description,
    LocalizedText? shortDescription,
    AdCustomer? customer,
    String? phoneNumber,
    User? performer,
    int? viewCount,
    String? city,
    String? moderatorNote,
    List<CategoryModel>? categories,
    List<AppImage>? images,
    bool? negotiable,
    num? price,
    AddressModel? address,
    bool? isNeedLiftUp,
    bool? isFavorite,
    int? clickCount,
  }) {
    return ServiceModel(
      id: id ?? this.id,
      status: status ?? this.status,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      shortDescription: shortDescription ?? this.shortDescription,
      customer: customer ?? this.customer,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      performer: performer ?? this.performer,
      viewCount: viewCount ?? this.viewCount,
      city: city ?? this.city,
      moderatorNote: moderatorNote ?? this.moderatorNote,
      categories: categories ?? this.categories,
      images: images ?? this.images,
      negotiable: negotiable ?? this.negotiable,
      price: price?.toDouble() ?? this.price,
      address: address ?? this.address,
      isNeedLiftUp: isNeedLiftUp ?? this.isNeedLiftUp,
      phoneNumber1: phoneNumber1 ?? this.phoneNumber1,
      phoneNumber2: phoneNumber2 ?? this.phoneNumber2,
      phoneNumber3: phoneNumber3 ?? this.phoneNumber3,
      isFavorite: isFavorite ?? this.isFavorite,
      clickCount: clickCount ?? this.clickCount,
    );
  }
}
