import '../../../../models/task_request.dart';

class PaginatedTaskRequestList {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<TaskRequest> items;
  final int totalCount;

  PaginatedTaskRequestList({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
  });

  factory PaginatedTaskRequestList.fromJson(Map<String, dynamic> json) {
    return PaginatedTaskRequestList(
      currentPageNumber: json['current_page_number'] ?? 0,
      numItemsPerPage: json['num_items_per_page'] ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => TaskRequest.fromMap(e)) 
          .toList() ??
          [],
      totalCount: json['total_count'] ?? 0,
    );
  }
  

  PaginatedTaskRequestList copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<TaskRequest>? items,
    int? totalCount,
  }) {
    return PaginatedTaskRequestList(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
