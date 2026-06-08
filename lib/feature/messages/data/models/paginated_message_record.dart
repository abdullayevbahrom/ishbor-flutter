import 'package:top_jobs/models/message_record.dart';
import 'package:top_jobs/core/network/api_response.dart';

class PaginatedMessageRecordResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final int totalCount;
  final List<MessageRecord> items;

  PaginatedMessageRecordResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.totalCount,
    required this.items,
  });

  PaginatedMessageRecordResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    int? totalCount,
    List<MessageRecord>? items,
  }) {
    return PaginatedMessageRecordResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      totalCount: totalCount ?? this.totalCount,
      items: items ?? this.items,
    );
  }

  factory PaginatedMessageRecordResponse.fromJson(Map<String, dynamic> json) {
    final response = ApiListResponse.fromJson(
      json,
      (item) => MessageRecord.fromMap(Map<String, dynamic>.from(item as Map)),
    );

    return PaginatedMessageRecordResponse(
      currentPageNumber: response.currentPageNumber ?? response.page ?? 1,
      numItemsPerPage: response.numItemsPerPage ?? 0,
      totalCount: response.totalCount ?? response.items.length,
      items: response.items,
    );
  }
}
