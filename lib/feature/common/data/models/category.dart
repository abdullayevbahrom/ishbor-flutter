import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

class CategoryTranslation extends Equatable {
  final int id;
  final String locale;
  final String? name;

  CategoryTranslation({
    required this.id,
    required this.locale,
    this.name,
  });

  @override
  List<Object?> get props => [id, locale, name];

  factory CategoryTranslation.fromJson(Map<String, dynamic> json) {
    return CategoryTranslation(
      id: json['id'] as int,
      locale: json['locale'] as String,
      name: json['name'] as String?,
    );
  }

  CategoryTranslation clone() =>
      CategoryTranslation(id: id, locale: locale, name: name);
}

class CategoryModel extends Equatable {
  final int id;
  final String path;
  final int level;
  final int? parent;
  final CategoryModel? parentObj;
  final Map<String, dynamic>? iconUrls;
  final Map<String, dynamic>? iconSmallUrls;
  final List<CategoryModel>? children;
  final List<CategoryTranslation> translations;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? currentLocale;
  final String? defaultLocale;

  CategoryModel({
    required this.id,
    required this.path,
    required this.level,
    this.parent,
    this.parentObj,
    this.iconUrls,
    this.iconSmallUrls,
    this.children,
    required this.translations,
    this.createdAt,
    this.updatedAt,
    this.currentLocale,
    this.defaultLocale,
  });

  @override
  List<Object?> get props =>
      [id, path, level, parent, children, translations, createdAt, updatedAt];

  factory CategoryModel.fromMap(Map<String, dynamic> data) {
    final childrenData = data['children'] as List<dynamic>? ?? [];
    final translationsData = data['translations'] as List<dynamic>? ?? [];

    return CategoryModel(
      id: data['id'] as int,
      path: data['path'] as String,
      level: data['level'] as int,
      parent: data['parent'] as int?,
      parentObj: data['parentObj'] != null
          ? CategoryModel.fromMap(Map<String, dynamic>.from(data['parentObj']))
          : null,
      iconUrls: data['icon'] != null
          ? data['icon'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(data['icon'])
          : null
          : null,
      iconSmallUrls: data['icon_small'] != null
          ? data['icon_small'] is Map<String, dynamic>
          ? Map<String, dynamic>.from(data['icon_small'])
          : null
          : null,
      children:
      childrenData.map((c) => CategoryModel.fromMap(Map<String, dynamic>.from(c))).toList(),
      translations: translationsData
          .map((t) => CategoryTranslation.fromJson(Map<String, dynamic>.from(t)))
          .toList(),
      createdAt: parseNullableDateTime(data['created_at']),
      updatedAt: parseNullableDateTime(data['updated_at']),
      currentLocale: data['current_locale'] as String?,
      defaultLocale: data['default_locale'] as String?,
    );
  }
}

class PaginatorOptions extends Equatable {
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

  @override
  List<Object?> get props => [
    pageParameterName,
    sortFieldParameterName,
    sortDirectionParameterName,
    filterFieldParameterName,
    filterValueParameterName,
    distinct,
    pageOutOfRange,
    defaultLimit,
  ];

  factory PaginatorOptions.fromMap(Map<String, dynamic> map) {
    return PaginatorOptions(
      pageParameterName: map['pageParameterName'] as String,
      sortFieldParameterName: map['sortFieldParameterName'] as String,
      sortDirectionParameterName: map['sortDirectionParameterName'] as String,
      filterFieldParameterName: map['filterFieldParameterName'] as String,
      filterValueParameterName: map['filterValueParameterName'] as String,
      distinct: map['distinct'] as bool,
      pageOutOfRange: map['pageOutOfRange'] as String,
      defaultLimit: map['defaultLimit'] as int,
    );
  }
}

class CustomParameters extends Equatable {
  final bool sorted;

  CustomParameters({required this.sorted});

  @override
  List<Object?> get props => [sorted];

  factory CustomParameters.fromMap(Map<String, dynamic> map) {
    return CustomParameters(sorted: map['sorted'] as bool);
  }
}

class CategoryListResponse extends Equatable {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<CategoryModel> items;
  final int totalCount;
  final PaginatorOptions paginatorOptions;
  final CustomParameters customParameters;
  final String route;
  final dynamic params;
  final int pageRange;
  final int? pageLimit;
  final String template;
  final String sortableTemplate;
  final String filtrationTemplate;

  CategoryListResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
    required this.paginatorOptions,
    required this.customParameters,
    required this.route,
    required this.params,
    required this.pageRange,
    this.pageLimit,
    required this.template,
    required this.sortableTemplate,
    required this.filtrationTemplate,
  });

  @override
  List<Object?> get props => [
    currentPageNumber,
    numItemsPerPage,
    items,
    totalCount,
    paginatorOptions,
    customParameters,
    route,
    params,
    pageRange,
    pageLimit,
    template,
    sortableTemplate,
    filtrationTemplate,
  ];

  factory CategoryListResponse.fromMap(Map<String, dynamic> map) {
    return CategoryListResponse(
      currentPageNumber: map['current_page_number'] as int,
      numItemsPerPage: map['num_items_per_page'] as int,
      items: (map['items'] as List<dynamic>)
          .map((item) => CategoryModel.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
      totalCount: map['total_count'] as int,
      paginatorOptions:
      PaginatorOptions.fromMap(Map<String, dynamic>.from(map['paginator_options'])),
      customParameters:
      CustomParameters.fromMap(Map<String, dynamic>.from(map['custom_parameters'])),
      route: map['route'] as String,
      params: map['params'],
      pageRange: map['page_range'] as int,
      pageLimit: map['page_limit'] as int?,
      template: map['template'] as String,
      sortableTemplate: map['sortable_template'] as String,
      filtrationTemplate: map['filtration_template'] as String,
    );
  }
}
