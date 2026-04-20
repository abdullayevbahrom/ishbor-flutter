
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
    return PaginatedFeedbackResponse(
      currentPageNumber: json['current_page_number'],
      numItemsPerPage: json['num_items_per_page'],
      items:(json['items'] as List<dynamic>)
          .map((item) => FeedbackModel.fromMap(item))
          .toList(),
      totalCount: json['total_count'],
      paginatorOptions: PaginatorOptions.fromMap(json['paginator_options']),
      customParameters: CustomParameters.fromMap(json['custom_parameters']),
      route: json['route'],
      params: json['params'] ?? {},
      pageRange: json['page_range'],
      pageLimit: json['page_limit'],
      template: json['template'],
      sortableTemplate: json['sortable_template'],
      filtrationTemplate: json['filtration_template'],
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


