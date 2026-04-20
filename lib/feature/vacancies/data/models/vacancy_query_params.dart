import 'dart:convert';

class QueryParams {
  final String? title;
  final bool? categoryAsText;
  final List<int>? categories;
  final bool? jobModesAsText;
  final List<String>? jobModes;
  final bool? employmentTypesAsText;
  final List<String>? employmentTypes;
  final int? size;
  final int? page;
  final String? city;
  final double? priceMin;
  final int? customer;

  QueryParams({
    this.title,
    this.categoryAsText = true,
    this.categories,
    this.jobModesAsText = true,
    this.jobModes,
    this.employmentTypesAsText = true,
    this.employmentTypes,
    this.city,
    this.priceMin,
    this.size,
    this.page,
    this.customer,
  });

  factory QueryParams.empty() => QueryParams(
    categories: [],
    employmentTypes: [],
    city: null,
    priceMin: null,
    title: null,
    customer: null,
  );

  bool get hasActiveFilters =>
      (categories ?? []).isNotEmpty ||
      (employmentTypes ?? []).isNotEmpty ||
      (city ?? '').isNotEmpty ||
      priceMin != null;

  Map<String, dynamic> toMap() {
    return {
      if (title != null && (title ?? '').isNotEmpty) 'title': title,
      if ((categories ?? []).isNotEmpty)
        'categories': jsonEncode(categories ?? []),
      if ((employmentTypes ?? []).isNotEmpty)
        'employmentTypes': jsonEncode(employmentTypes ?? []),
      'size': size,
      'page': page,
      if (city != null && (city ?? '').isNotEmpty) "city": city,
      if (priceMin != null) "priceMin": priceMin,
      if (customer != null) "customer": customer,
    };
  }
}
