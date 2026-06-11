import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

import 'api_model_utils.dart';

class File extends Equatable {
  final String id;
  final String url;
  final DateTime createdAt;
  final String originalName;
  final String extension;
  final String mimeType;

  const File({
    required this.id,
    required this.url,
    required this.createdAt,
    required this.originalName,
    required this.extension,
    required this.mimeType,
  });

  @override
  List<Object> get props => [
    id,
    url,
    createdAt,
    originalName,
    extension,
    mimeType,
  ];

  static File fromMap(Map<String, dynamic> data) {
    return File.fromJson(data);
  }

  static File fromJson(dynamic source) {
    try {
      if (kDebugMode) {
        debugPrint('[FIX] File.fromJson input type: ${source.runtimeType}');
      }

      final file = _fromJsonUnsafe(source);

      if (kDebugMode) {
        debugPrint(
          '[FIX] File.fromJson normalized: id=${file.id}, url=${file.url}, originalName=${file.originalName}, extension=${file.extension}',
        );
      }

      return file;
    } catch (error, stackTrace) {
      if (kDebugMode) {
        debugPrint(
          '[FIX] File.fromJson failed for type ${source.runtimeType}: $error',
        );
        debugPrint(stackTrace.toString());
      }
      rethrow;
    }
  }
}

File _fromJsonUnsafe(dynamic source) {
  if (source is String) {
    final url = source.trim();
    final fileName = _fileNameFromUrl(url);
    final dotIndex = fileName.lastIndexOf('.');
    return File(
      id: url,
      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
      url: url,
      originalName: dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName,
      extension: dotIndex > 0 ? fileName.substring(dotIndex + 1) : '',
      mimeType: '',
    );
  }

  final data = unwrapData(source);
  final urls = asMap(data['urls']);
  final url =
      stringValue(
        data['url'] ?? data['original'] ?? data['path'] ?? urls['original'],
      ) ??
      '';
  final fileName =
      stringValue(data['original_name'] ?? data['originalName']) ??
      _fileNameFromUrl(url);
  final dotIndex = fileName.lastIndexOf('.');
  final originalName =
      dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;

  return File(
    id: stringValue(data['id']) ?? (url.isNotEmpty ? url : ''),
    createdAt: parseRequiredDateTime(data['created_at']),
    url: url,
    originalName: originalName,
    extension:
        stringValue(data['extension']) ??
        (dotIndex > 0 ? fileName.substring(dotIndex + 1) : ''),
    mimeType: stringValue(data['mime_type']) ?? '',
  );
}

String _fileNameFromUrl(String url) {
  if (url.isEmpty) {
    return '';
  }

  final parsed = Uri.tryParse(url);
  if (parsed == null) {
    return url.split('/').last;
  }

  if (parsed.pathSegments.isEmpty) {
    return url.split('/').last;
  }

  return parsed.pathSegments.last;
}
