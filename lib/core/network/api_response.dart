import 'package:flutter/foundation.dart';

class ApiDataResponse<T> {
  final T? data;
  final String? message;
  final Map<String, dynamic> raw;

  const ApiDataResponse({required this.data, required this.raw, this.message});

  factory ApiDataResponse.fromJson(
    dynamic source,
    T Function(dynamic json) fromJsonT, {
    String? dataKey,
  }) {
    final raw = _asMap(source);
    final payload = dataKey == null ? _unwrapData(raw) : raw[dataKey];

    if (payload == null && raw.isNotEmpty) {
      _warnMalformed('ApiDataResponse', raw);
    }

    return ApiDataResponse<T>(
      data: payload == null ? null : fromJsonT(payload),
      message: _asString(raw['message']),
      raw: raw,
    );
  }
}

class ApiListResponse<T> {
  final List<T> items;
  final int? totalCount;
  final int? page;
  final int? numItemsPerPage;
  final int? currentPageNumber;
  final Map<String, dynamic> raw;

  const ApiListResponse({
    required this.items,
    required this.raw,
    this.totalCount,
    this.page,
    this.numItemsPerPage,
    this.currentPageNumber,
  });

  factory ApiListResponse.fromJson(
    dynamic source,
    T Function(dynamic json) fromJsonT, {
    String? dataKey,
  }) {
    final raw = _asMap(source);
    final payload = dataKey == null ? _unwrapData(raw) : raw[dataKey];
    final map = payload is Map<String, dynamic> ? payload : raw;
    final itemsSource = _asList(map['items']);

    if (itemsSource == null && raw.isNotEmpty) {
      _warnMalformed('ApiListResponse', raw);
    }

    return ApiListResponse<T>(
      items: (itemsSource ?? const <dynamic>[])
          .map(fromJsonT)
          .toList(growable: false),
      totalCount: _asInt(map['total_count']) ?? _asInt(map['totalCount']),
      page: _asInt(map['page']),
      numItemsPerPage:
          _asInt(map['num_items_per_page']) ?? _asInt(map['numItemsPerPage']),
      currentPageNumber:
          _asInt(map['current_page_number']) ??
          _asInt(map['currentPageNumber']),
      raw: raw,
    );
  }
}

Map<String, dynamic> _asMap(dynamic source) {
  if (source is Map<String, dynamic>) {
    return Map<String, dynamic>.from(source);
  }

  if (source is Map) {
    return Map<String, dynamic>.fromEntries(
      source.entries.map(
        (entry) => MapEntry(entry.key.toString(), entry.value),
      ),
    );
  }

  if (source == null) {
    return <String, dynamic>{};
  }

  _warnMalformed('ApiResponse', <String, dynamic>{'value': source});
  return <String, dynamic>{};
}

dynamic _unwrapData(Map<String, dynamic> raw) {
  if (raw.containsKey('data')) {
    return raw['data'];
  }

  if (raw.containsKey('items') || raw.containsKey('total_count')) {
    return raw;
  }

  return raw.isEmpty ? null : raw;
}

List<dynamic>? _asList(dynamic source) {
  if (source is List) {
    return source;
  }

  return null;
}

int? _asInt(dynamic source) {
  if (source == null) {
    return null;
  }
  if (source is int) {
    return source;
  }
  if (source is num) {
    return source.toInt();
  }
  if (source is String) {
    return int.tryParse(source);
  }

  return null;
}

String? _asString(dynamic source) {
  if (source == null) {
    return null;
  }

  return source.toString();
}

void _warnMalformed(String name, Map<String, dynamic> raw) {
  if (kDebugMode) {
    debugPrint(
      '[API][normalize][warn] $name malformed payload: ${raw.keys.toList()}',
    );
  }
}
