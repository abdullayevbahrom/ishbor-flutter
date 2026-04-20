import 'package:top_jobs/models/message_record.dart';


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
    return PaginatedMessageRecordResponse(
      currentPageNumber: json['current_page_number'],
      numItemsPerPage: json['num_items_per_page'],
      totalCount: json['total_count'],
      items:
          (json['items'] as List).map((e) => MessageRecord.fromMap(e)).toList(),
    );
  }
}
