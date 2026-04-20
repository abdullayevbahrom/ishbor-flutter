import '../../../../models/user.dart';
import '../../../../core/helpers/date_time_parser.dart';
import '../../../services/data/models/service.dart';

class NotificationListResponse {
  final int currentPageNumber;
  final int numItemsPerPage;
  final List<AppNotification> items;
  final int totalCount;
  final PaginatorOptions paginatorOptions;
  final Map<String, dynamic> customParameters;
  final String route;
  final List<dynamic> params;
  final int pageRange;
  final dynamic pageLimit;
  final String template;
  final String sortableTemplate;
  final String filtrationTemplate;

  NotificationListResponse({
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

  factory NotificationListResponse.fromMap(Map<String, dynamic> map) {
    return NotificationListResponse(
      currentPageNumber: map['current_page_number'],
      numItemsPerPage: map['num_items_per_page'],
      items: List<AppNotification>.from(
        map['items'].map((x) => AppNotification.fromMap(x)),
      ),
      totalCount: map['total_count'],
      paginatorOptions: PaginatorOptions.fromMap(map['paginator_options']),
      customParameters: Map<String, dynamic>.from(map['custom_parameters']),
      route: map['route'],
      params: List<dynamic>.from(map['params']),
      pageRange: map['page_range'],
      pageLimit: map['page_limit'],
      template: map['template'],
      sortableTemplate: map['sortable_template'],
      filtrationTemplate: map['filtration_template'],
    );
  }

  NotificationListResponse copyWith({
    int? currentPageNumber,
    int? numItemsPerPage,
    List<AppNotification>? items,
    int? totalCount,
    PaginatorOptions? paginatorOptions,
    Map<String, dynamic>? customParameters,
    String? route,
    List<dynamic>? params,
    int? pageRange,
    dynamic pageLimit,
    String? template,
    String? sortableTemplate,
    String? filtrationTemplate,
  }) {
    return NotificationListResponse(
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

class AppNotification {
  final int id;
  final String type;
  final String operation;
  final int operationId;
  final User receiver;
  final bool read;
  final String title;
  final String body;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? titleUz;
  final String? titleRu;
  final String? bodyUz;
  final String? bodyRu;

  AppNotification({
    required this.id,
    required this.type,
    required this.operation,
    required this.operationId,
    required this.receiver,
    required this.read,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    this.titleUz,
    this.titleRu,
    this.bodyUz,
    this.bodyRu,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'],
      type: map['type'],
      operation: map['operation'],
      operationId: map['operation_id'],
      receiver: User.fromMap(map['receiver']),
      read: map['read'],
      title: map['title'],
      body: map['body'],
      createdAt: parseRequiredDateTime(map['created_at']),
      updatedAt: parseRequiredDateTime(map['updated_at']),
      bodyRu: map['body_ru'],
      bodyUz: map['body_uz'],
      titleRu: map['title_ru'],
      titleUz: map['title_uz'],
    );
  }

  AppNotification copyWith({
    int? id,
    String? type,
    String? operation,
    int? operationId,
    User? receiver,
    bool? read,
    String? title,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? titleUz,
    String? titleRu,
    String? bodyUz,
    String? bodyRu,
  }) {
    return AppNotification(
      id: id ?? this.id,
      type: type ?? this.type,
      operation: operation ?? this.operation,
      operationId: operationId ?? this.operationId,
      receiver: receiver ?? this.receiver,
      read: read ?? this.read,
      title: title ?? this.title,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      titleRu: titleRu ?? this.titleRu,
      titleUz: titleUz ?? this.titleUz,
      bodyRu: bodyRu ?? this.bodyRu,
      bodyUz: bodyUz ?? this.bodyUz,
    );
  }
}
