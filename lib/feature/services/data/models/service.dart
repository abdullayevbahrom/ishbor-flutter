import '../../../../models/ad_pricable.dart';
import '../../../../models/address.dart';
import '../../../../core/helpers/date_time_parser.dart';
import '../../../../models/image.dart';
import '../../../../models/user.dart';
import '../../../common/data/models/category.dart';

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
    return PaginatedServiceResponse(
      currentPageNumber: json['current_page_number'],
      numItemsPerPage: json['num_items_per_page'],
      items: List<ServiceModel>.from(
        json['items'].map((item) => ServiceModel.fromMap(item)),
      ),
      totalCount: json['total_count'],
      paginatorOptions: PaginatorOptions.fromMap(json['paginator_options']),
      customParameters: json['custom_parameters'],
      route: json['route'],
      params: json['params'],
      pageRange: json['page_range'],
      pageLimit: json['page_limit'],
      template: json['template'],
      sortableTemplate: json['sortable_template'],
      filtrationTemplate: json['filtration_template'],
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
      customParameters:
          customParameters != null ? customParameters : this.customParameters,
      route: route ?? this.route,
      params: params != null ? params : this.params,
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

  factory CustomParameters.fromMap(Map<String, dynamic> json) {
    return CustomParameters(sorted: json['sorted']);
  }
}

class ServiceModel extends AdPricable {
  final AddressModel? address;
  final bool? isNeedLiftUp;
  final String? phoneNumber1;
  final String? phoneNumber2;
  final String? phoneNumber3;
  final bool? isFavorite;
  final int? clickCount;

  ServiceModel({
    this.phoneNumber1,
    this.phoneNumber2,
    this.phoneNumber3,
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
    price,
    negotiable,
    titleUz,
    titleRu,
    descriptionUz,
    descriptionRu,
    shortDescriptionUz,
    shortDescriptionRu,
    this.address,
    this.isNeedLiftUp,
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
         price: price,
         titleUz: titleUz,
         titleRu: titleRu,
         descriptionUz: descriptionUz,
         descriptionRu: descriptionRu,
         shortDescriptionRu: shortDescriptionRu,
         shortDescriptionUz: shortDescriptionUz,
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
    isFavorite
  ];

  static ServiceModel fromMap(Map<String, dynamic> data) => ServiceModel(
    id: data['id'],
    status: data['status'],
    title: data['title'],
    createdAt: parseRequiredDateTime(data['created_at']),
    description: data['description'] ?? '',
    shortDescription: data['short_description'] ?? '',
    customer: User.fromMap(data['customer']),
    phoneNumber: data['phone_number'],
    performer:
        data['performer'] != null ? User.fromMap(data['performer']) : null,
    viewCount: data['view_count'],
    city: data['city'],
    moderatorNote: data['moderator_note'],
    categories:
        List.from(
          data['categories'],
        ).map((cat) => CategoryModel.fromMap(cat)).toList(),
    address:
        data['address'] != null ? AddressModel.fromJson(data['address']) : null,
    images:
        List.from(
          data['images'] ?? const [],
        ).map((img) => AppImage.fromMap(Map.from(img))).toList(),
    negotiable: data['negotiable'],
    price: data['price'],
    isNeedLiftUp: data['is_need_lift_up'],
    titleUz: data['title_uz'],
    titleRu: data['title_ru'],
    descriptionRu: data['description_ru'],
    descriptionUz: data['description_uz'],
    shortDescriptionUz: data['short_description_uz'],
    shortDescriptionRu: data['short_description_ru'],
    phoneNumber1: data['phone_number1'],
    phoneNumber2: data['phone_number2'],
    phoneNumber3: data['phone_number3'],
    clickCount: data['click_count'],
    isFavorite: data['is_favorite']
  );

  ServiceModel copyWith({
    String? phoneNumber1,
    String? phoneNumber2,
    String? phoneNumber3,
    String? id,
    String? status,
    String? title,
    DateTime? createdAt,
    String? description,
    String? shortDescription,
    User? customer,
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
    String? titleUz,
    String? titleRu,
    String? descriptionUz,
    String? descriptionRu,
    String? shortDescriptionUz,
    String? shortDescriptionRu,
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
      price: price ?? this.price,
      address: address ?? this.address,
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
      isFavorite: isFavorite??this.isFavorite,
      clickCount: clickCount??this.clickCount
    );
  }
}
