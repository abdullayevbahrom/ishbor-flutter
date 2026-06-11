import '../../../../models/feedback.dart';
import '../../../services/data/models/service.dart';

class PaginatedFeedbackResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<FeedbackModel> items;
  final int totalCount;
  final PaginatorOptions paginatorOptions;
  final CustomParameters customParameters;
  final String route;
  final Map<String, dynamic> params;
  final int pageRange;
  final dynamic pageLimit;
  final String template;
  final String sortableTemplate;
  final String filtrationTemplate;

  PaginatedFeedbackResponse({
    required this.currentPageNumber,
    required this.numItemsPerPage,
    required this.items,
    required this.totalCount,
    required this.paginatorOptions,
    required this.customParameters,
    required this.route,
    required this.params,
    required this.pageRange,
    required this.pageLimit,
    required this.template,
    required this.sortableTemplate,
    required this.filtrationTemplate,
  });

  factory PaginatedFeedbackResponse.fromJson(Map<String, dynamic> json) {
    final payload =
        json['data'] is Map<String, dynamic>
            ? Map<String, dynamic>.from(json['data'] as Map<String, dynamic>)
            : json;
    final rawItems = payload['items'] as List<dynamic>? ?? const [];
    return PaginatedFeedbackResponse(
      currentPageNumber: payload['current_page_number'] ?? 1,
      numItemsPerPage: payload['num_items_per_page'] ?? rawItems.length,
      items:
          rawItems
              .map(
                (item) =>
                    FeedbackModel.fromMap(Map<String, dynamic>.from(item)),
              )
              .toList(),
      totalCount: payload['total_count'] ?? rawItems.length,
      paginatorOptions: PaginatorOptions.fromMap(
        payload['paginator_options'] ?? const {},
      ),
      customParameters: CustomParameters.fromMap(
        payload['custom_parameters'] ?? const {},
      ),
      route: payload['route'] ?? '',
      params: payload['params'] ?? {},
      pageRange: payload['page_range'] ?? 1,
      pageLimit: payload['page_limit'],
      template: payload['template'] ?? '',
      sortableTemplate: payload['sortable_template'] ?? '',
      filtrationTemplate: payload['filtration_template'] ?? '',
    );
  }

  PaginatedFeedbackResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<FeedbackModel>? items,
    int? totalCount,
    PaginatorOptions? paginatorOptions,
    CustomParameters? customParameters,
    String? route,
    Map<String, dynamic>? params,
    int? pageRange,
    dynamic pageLimit,
    String? template,
    String? sortableTemplate,
    String? filtrationTemplate,
  }) {
    return PaginatedFeedbackResponse(
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
}
