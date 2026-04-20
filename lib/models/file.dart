import 'package:equatable/equatable.dart';
import 'package:top_jobs/core/helpers/date_time_parser.dart';

class File extends Equatable {

  final int id;
  final String url;
  final DateTime createdAt;
  final String originalName;
  final String extension;
  final String mimeType;

  File({ required this.id, required this.url, required this.createdAt, required this.originalName,
    required this.extension, required this.mimeType });

  List<Object> get props => [id, url, createdAt, originalName, extension, mimeType];

  static File fromMap(Map<String, dynamic> data) {
    return File(
        id: data['id'],
        createdAt: parseRequiredDateTime(data['created_at']),
        url: data['url'],
        originalName: data['original_name'],
        extension: data['extension'],
        mimeType: data['mime_type']
    );
  }
}
