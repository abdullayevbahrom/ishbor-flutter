import 'package:top_jobs/models/api_model_utils.dart';
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
        currentPageNumber: intValue(json["page"] ?? json["current_page_number"] ?? json["currentPageNumber"]) ?? 1,
        numItemsPerPage: intValue(json["size"] ?? json["num_items_per_page"] ?? json["numItemsPerPage"]) ?? 20,
        items: List<TaskRequest>.from(
          (json["items"] as List? ?? []).map((x) => TaskRequest.fromMap(x)),
        ),
        totalCount: intValue(json["total"] ?? json["total_count"] ?? json["totalCount"]) ?? 0,
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
