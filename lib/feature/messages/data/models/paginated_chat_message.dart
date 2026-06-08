import '../../../../models/message.dart';
import '../../../../core/network/api_response.dart';

class PaginatedChatMessageResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final int totalCount;
  final List<Message> items;

  PaginatedChatMessageResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.totalCount,
    required this.items,
  });

  PaginatedChatMessageResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    int? totalCount,
    List<Message>? items,
  }) {
    return PaginatedChatMessageResponse(
      currentPageNumber: currentPageNumber ?? this.currentPageNumber,
      numItemsPerPage: numItemsPerPage ?? this.numItemsPerPage,
      totalCount: totalCount ?? this.totalCount,
      items: items ?? this.items,
    );
  }

  factory PaginatedChatMessageResponse.fromJson(Map<String, dynamic> json) {
    final response = ApiListResponse.fromJson(
      json,
      (item) => Message.fromMap(Map<String, dynamic>.from(item as Map)),
    );

    return PaginatedChatMessageResponse(
      currentPageNumber: response.currentPageNumber ?? response.page ?? 1,
      numItemsPerPage: response.numItemsPerPage ?? 0,
      totalCount: response.totalCount ?? response.items.length,
      items: response.items,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'current_page_number': currentPageNumber,
  //     'num_items_per_page': numItemsPerPage,
  //     'total_count': totalCount,
  //     'items': items.map((e) => e.toJson()).toList(),
  //   };
  // }
}
