import 'package:top_jobs/models/vacancy_request.dart';

class PaginatedVacancyRequestList {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<VacancyRequest> items;
  final int totalCount;

  PaginatedVacancyRequestList({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
  });

  factory PaginatedVacancyRequestList.fromMap(Map<String, dynamic> json) {
    return PaginatedVacancyRequestList(
      currentPageNumber:
          json['current_page_number'] is num
              ? (json['current_page_number'] as num).toInt()
              : 0,
      numItemsPerPage:
          json['num_items_per_page'] is num
              ? (json['num_items_per_page'] as num).toInt()
              : 0,
      items:
          (json['items'] as List?)
              ?.map((e) => VacancyRequest.fromMap(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
      totalCount:
          json['total_count'] is num ? (json['total_count'] as num).toInt() : 0,
    );
  }

  PaginatedVacancyRequestList copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<VacancyRequest>? items,
    int? totalCount,
  }) {
    return PaginatedVacancyRequestList(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
