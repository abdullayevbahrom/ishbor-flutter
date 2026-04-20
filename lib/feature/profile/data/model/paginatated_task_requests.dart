
import 'package:top_jobs/models/task_request.dart';

class PaginatedTaskResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<TaskRequest> items;
  final int totalCount;

  PaginatedTaskResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
  });

  factory PaginatedTaskResponse.fromJson(Map<String, dynamic> json) =>
      PaginatedTaskResponse(
        currentPageNumber: json["current_page_number"],
        numItemsPerPage: json["num_items_per_page"],
        items: List<TaskRequest>.from(
          json["items"].map((x) => TaskRequest.fromMap(x)),
        ),
        totalCount: json["total_count"],
      );

  PaginatedTaskResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<TaskRequest>? items,
    int? totalCount,
  }) {
    return PaginatedTaskResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
