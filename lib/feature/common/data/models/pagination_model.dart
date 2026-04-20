/// Common pagination wrapper that you can reuse everywhere.
/// Works with KnpPaginator-like responses (items + meta fields).
///
/// Usage:
/// final res = PaginationResponse<NewVacancyModel>.fromJson(
///   json,
///   (e) => NewVacancyModel.fromJson(e),
/// );
///
/// final items = res.items; // List<NewVacancyModel>?

class PaginationResponse<T> {
  final int? currentPageNumber;
  final int? numItemsPerPage;
  final List<T>? items;
  final int? totalCount;

  final PaginatorOptions? paginatorOptions;
  final Map<String, dynamic>? customParameters;
  final String? route;
  final Map<String, dynamic>? params;

  final int? pageRange;
  final int? pageLimit;

  final String? template;
  final String? sortableTemplate;
  final String? filtrationTemplate;

  const PaginationResponse({
    this.currentPageNumber,
    this.numItemsPerPage,
    this.items,
    this.totalCount,
    this.paginatorOptions,
    this.customParameters,
    this.route,
    this.params,
    this.pageRange,
    this.pageLimit,
    this.template,
    this.sortableTemplate,
    this.filtrationTemplate,
  });

  PaginationResponse<T> copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<T>? items,
    int? totalCount,
    PaginatorOptions? paginatorOptions,
    Map<String, dynamic>? customParameters,
    String? route,
    Map<String, dynamic>? params,
    int? pageRange,
    int? pageLimit,
    String? template,
    String? sortableTemplate,
    String? filtrationTemplate,
  }) {
    return PaginationResponse<T>(
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

  factory PaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Map<String, dynamic> itemJson) itemFromJson,
      ) {
    return PaginationResponse<T>(
      currentPageNumber: _asInt(json['current_page_number']),
      numItemsPerPage: _asInt(json['num_items_per_page']),
      items: _asListMap(json['items'])
          ?.map((e) => itemFromJson(e))
          .toList(),
      totalCount: _asInt(json['total_count']),
      paginatorOptions: json['paginator_options'] is Map<String, dynamic>
          ? PaginatorOptions.fromJson(json['paginator_options'])
          : null,
      customParameters: _asMap(json['custom_parameters']),
      route: _asString(json['route']),
      params: _asMap(json['params']),
      pageRange: _asInt(json['page_range']),
      pageLimit: _asInt(json['page_limit']),
      template: _asString(json['template']),
      sortableTemplate: _asString(json['sortable_template']),
      filtrationTemplate: _asString(json['filtration_template']),
    );
  }

  Map<String, dynamic> toJson(
      Map<String, dynamic> Function(T item) itemToJson,
      ) {
    return {
      'current_page_number': currentPageNumber,
      'num_items_per_page': numItemsPerPage,
      'items': items?.map(itemToJson).toList(),
      'total_count': totalCount,
      'paginator_options': paginatorOptions?.toJson(),
      'custom_parameters': customParameters,
      'route': route,
      'params': params,
      'page_range': pageRange,
      'page_limit': pageLimit,
      'template': template,
      'sortable_template': sortableTemplate,
      'filtration_template': filtrationTemplate,
    };
  }

  // Convenient computed helpers
  bool get hasItems => (items?.isNotEmpty ?? false);
  int? get totalPages {
    final total = totalCount;
    final per = numItemsPerPage;
    if (total == null || per == null || per == 0) return null;
    return (total / per).ceil();
  }

  bool get hasNextPage {
    final page = currentPageNumber;
    final tp = totalPages;
    if (page == null || tp == null) return false;
    return page < tp;
  }

  // ------- helpers -------
  static Map<String, dynamic>? _asMap(dynamic v) => v is Map<String, dynamic> ? v : null;

  static List<Map<String, dynamic>>? _asListMap(dynamic v) {
    if (v is List) {
      return v.whereType<Map<String, dynamic>>().toList();
    }
    return null;
  }

  static String? _asString(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    return v.toString();
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }
}

class PaginatorOptions {
  final String? pageParameterName;
  final String? sortFieldParameterName;
  final String? sortDirectionParameterName;
  final String? filterFieldParameterName;
  final String? filterValueParameterName;

  final bool? distinct;
  final String? pageOutOfRange;
  final int? defaultLimit;

  const PaginatorOptions({
    this.pageParameterName,
    this.sortFieldParameterName,
    this.sortDirectionParameterName,
    this.filterFieldParameterName,
    this.filterValueParameterName,
    this.distinct,
    this.pageOutOfRange,
    this.defaultLimit,
  });

  PaginatorOptions copyWith({
    String? pageParameterName,
    String? sortFieldParameterName,
    String? sortDirectionParameterName,
    String? filterFieldParameterName,
    String? filterValueParameterName,
    bool? distinct,
    String? pageOutOfRange,
    int? defaultLimit,
  }) {
    return PaginatorOptions(
      pageParameterName: pageParameterName ?? this.pageParameterName,
      sortFieldParameterName: sortFieldParameterName ?? this.sortFieldParameterName,
      sortDirectionParameterName:
      sortDirectionParameterName ?? this.sortDirectionParameterName,
      filterFieldParameterName:
      filterFieldParameterName ?? this.filterFieldParameterName,
      filterValueParameterName:
      filterValueParameterName ?? this.filterValueParameterName,
      distinct: distinct ?? this.distinct,
      pageOutOfRange: pageOutOfRange ?? this.pageOutOfRange,
      defaultLimit: defaultLimit ?? this.defaultLimit,
    );
  }

  factory PaginatorOptions.fromJson(Map<String, dynamic> json) {
    return PaginatorOptions(
      pageParameterName: _asString(json['pageParameterName']),
      sortFieldParameterName: _asString(json['sortFieldParameterName']),
      sortDirectionParameterName: _asString(json['sortDirectionParameterName']),
      filterFieldParameterName: _asString(json['filterFieldParameterName']),
      filterValueParameterName: _asString(json['filterValueParameterName']),
      distinct: _asBool(json['distinct']),
      pageOutOfRange: _asString(json['pageOutOfRange']),
      defaultLimit: _asInt(json['defaultLimit']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pageParameterName': pageParameterName,
      'sortFieldParameterName': sortFieldParameterName,
      'sortDirectionParameterName': sortDirectionParameterName,
      'filterFieldParameterName': filterFieldParameterName,
      'filterValueParameterName': filterValueParameterName,
      'distinct': distinct,
      'pageOutOfRange': pageOutOfRange,
      'defaultLimit': defaultLimit,
    };
  }

  static String? _asString(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    return v.toString();
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }

  static bool? _asBool(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase().trim();
      if (s == 'true' || s == '1' || s == 'yes') return true;
      if (s == 'false' || s == '0' || s == 'no') return false;
    }
    return null;
  }
}
