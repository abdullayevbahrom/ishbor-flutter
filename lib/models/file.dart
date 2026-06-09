import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

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
  List<Object> get props => [id, url, createdAt, originalName, extension, mimeType];

  static File fromMap(Map<String, dynamic> data) {
    return File(
      id: data['id']?.toString() ?? '',
      createdAt: parseRequiredDateTime(data['created_at']),
      url: data['url']?.toString() ?? '',
      originalName: data['original_name']?.toString() ?? '',
      extension: data['extension']?.toString() ?? '',
      mimeType: data['mime_type']?.toString() ?? '',
    );
  }
}
