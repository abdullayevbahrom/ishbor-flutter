import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

import '../../../../models/api_model_utils.dart';

class CategoryTranslation extends Equatable {
  final String id;
  final String locale;
  final String? name;

  CategoryTranslation({required this.id, required this.locale, this.name});

  @override
  List<Object?> get props => [id, locale, name];

  factory CategoryTranslation.fromJson(dynamic source) {
    if (source is String) {
      return CategoryTranslation(id: source, locale: 'uz', name: source);
    }

    final json = asMap(source);
    return CategoryTranslation(
      id: stringValue(json['id']) ?? '',
      locale: stringValue(json['locale']) ?? '',
      name: stringValue(json['name']),
    );
  }

  CategoryTranslation clone() =>
      CategoryTranslation(id: id, locale: locale, name: name);
}

class CategoryModel extends Equatable {
  final String id;
  final String path;
  final int level;
  final String? parent;
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
  List<Object?> get props => [
    id,
    path,
    level,
    parent,
    children,
    translations,
    createdAt,
    updatedAt,
  ];

  factory CategoryModel.fromMap(dynamic source) {
    if (source is String) {
      return CategoryModel(
        id: source,
        path: '',
        level: 0,
        translations: _categoryTranslationsFromSource(
          source,
          fallbackId: source,
        ),
      );
    }

    final data = unwrapData(source);
    final childrenData = data['children'];
    final translationsData = data['translations'] ?? data['name'];

    return CategoryModel(
      id: stringValue(data['id']) ?? '',
      path: stringValue(data['path'] ?? data['slug']) ?? '',
      level: intValue(data['level']) ?? 0,
      parent: stringValue(data['parent'] ?? data['parent_id']),
      parentObj:
          data['parentObj'] != null
              ? CategoryModel.fromMap(data['parentObj'])
              : null,
      iconUrls: _iconUrlsFromSource(data['icon']),
      iconSmallUrls: _iconUrlsFromSource(data['icon_small']),
      children: mappedList(childrenData, CategoryModel.fromMap),
      translations: _categoryTranslationsFromSource(
        translationsData,
        fallbackId: stringValue(data['id']) ?? '',
      ),
      createdAt: parseNullableDateTime(data['created_at']),
      updatedAt: parseNullableDateTime(data['updated_at']),
      currentLocale: stringValue(data['current_locale']),
      defaultLocale: stringValue(data['default_locale']),
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
      pageParameterName:
          stringValue(map['pageParameterName'] ?? map['page_parameter_name']) ??
          'page',
      sortFieldParameterName:
          stringValue(
            map['sortFieldParameterName'] ?? map['sort_field_parameter_name'],
          ) ??
          '',
      sortDirectionParameterName:
          stringValue(
            map['sortDirectionParameterName'] ??
                map['sort_direction_parameter_name'],
          ) ??
          '',
      filterFieldParameterName:
          stringValue(
            map['filterFieldParameterName'] ??
                map['filter_field_parameter_name'],
          ) ??
          '',
      filterValueParameterName:
          stringValue(
            map['filterValueParameterName'] ??
                map['filter_value_parameter_name'],
          ) ??
          '',
      distinct: boolValue(map['distinct']) ?? false,
      pageOutOfRange:
          stringValue(map['pageOutOfRange'] ?? map['page_out_of_range']) ?? '',
      defaultLimit: intValue(map['defaultLimit'] ?? map['default_limit']) ?? 0,
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

class CustomParameters extends Equatable {
  final bool sorted;

  CustomParameters({required this.sorted});

  @override
  List<Object?> get props => [sorted];

  factory CustomParameters.fromMap(Map<String, dynamic> map) {
    return CustomParameters(sorted: boolValue(map['sorted']) ?? false);
  }

  factory CustomParameters.empty() {
    return CustomParameters(sorted: false);
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
    final payload = asMap(unwrapData(map));
    final items = mappedList(payload['items'], CategoryModel.fromMap);
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
        '[FIX] CategoryListResponse.fromMap normalized minimal list payload: items=${items.length}, totalCount=$totalCount',
      );
    }

    return CategoryListResponse(
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
}

Map<String, dynamic>? _iconUrlsFromSource(dynamic source) {
  if (source is String) {
    final value = source.trim();
    if (value.isEmpty) {
      return null;
    }

    return {'original': value};
  }

  if (source is Map) {
    return asMap(source);
  }

  return null;
}

List<CategoryTranslation> _categoryTranslationsFromSource(
  dynamic source, {
  required String fallbackId,
}) {
  if (source is List) {
    final byLocale = <String, CategoryTranslation>{};

    for (final item in source) {
      final translation = CategoryTranslation.fromJson(item);
      if (translation.locale.isNotEmpty) {
        byLocale[translation.locale] = translation;
      }
    }

    if (byLocale.isNotEmpty) {
      return _normalizeCategoryTranslations(byLocale, fallbackId: fallbackId);
    }
  }

  final map = asMap(source);
  if (map.isNotEmpty) {
    final byLocale = <String, CategoryTranslation>{};
    for (final locale in ['ru', 'uz', 'en']) {
      final value = stringValue(map[locale]);
      if (value != null && value.trim().isNotEmpty) {
        byLocale[locale] = CategoryTranslation(
          id: '$fallbackId:$locale',
          locale: locale,
          name: value.trim(),
        );
      }
    }

    if (byLocale.isNotEmpty) {
      return _normalizeCategoryTranslations(byLocale, fallbackId: fallbackId);
    }

    final fallback = stringValue(map['value']) ?? map.values.first.toString();
    return [
      CategoryTranslation(id: '$fallbackId:ru', locale: 'ru', name: fallback),
      CategoryTranslation(id: '$fallbackId:uz', locale: 'uz', name: fallback),
    ];
  }

  if (source is String && source.trim().isNotEmpty) {
    final value = source.trim();
    return [
      CategoryTranslation(id: '$fallbackId:ru', locale: 'ru', name: value),
      CategoryTranslation(id: '$fallbackId:uz', locale: 'uz', name: value),
    ];
  }

  return [
    CategoryTranslation(id: '$fallbackId:ru', locale: 'ru', name: null),
    CategoryTranslation(id: '$fallbackId:uz', locale: 'uz', name: null),
  ];
}

List<CategoryTranslation> _normalizeCategoryTranslations(
  Map<String, CategoryTranslation> byLocale, {
  required String fallbackId,
}) {
  final fallbackName =
      byLocale['ru']?.name ?? byLocale['uz']?.name ?? byLocale['en']?.name;

  final ru =
      byLocale['ru'] ??
      CategoryTranslation(
        id: '$fallbackId:ru',
        locale: 'ru',
        name: fallbackName,
      );
  final uz =
      byLocale['uz'] ??
      CategoryTranslation(
        id: '$fallbackId:uz',
        locale: 'uz',
        name: fallbackName ?? ru.name,
      );

  final translations = [ru, uz];
  final en = byLocale['en'];
  if (en != null) {
    translations.add(en);
  }

  if (kDebugMode) {
    debugPrint(
      '[FIX] CategoryModel.fromMap synthesized translations: ru=${ru.name}, uz=${uz.name}',
    );
  }

  return translations;
}
