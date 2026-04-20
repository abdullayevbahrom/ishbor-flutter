import '../../../../models/message.dart';

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
    return PaginatedChatMessageResponse(
      currentPageNumber: json['current_page_number'],
      numItemsPerPage: json['num_items_per_page'],
      totalCount: json['total_count'],
      items: (json['items'] as List)
          .map((e) => Message.fromMap(e))
          .toList(),
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
