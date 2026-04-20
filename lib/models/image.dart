import 'package:equatable/equatable.dart';

class AppImage extends Equatable {

  final int id;
  final String originalName;
  final String extension;
  final Map<String, dynamic> urls;

  AppImage({
    required this.id,
    required this.originalName,
    required this.extension,
    required this.urls
  });

  @override
  List<Object> get props => [id, originalName, extension, urls];

  static AppImage fromMap(Map<String, dynamic> data) {
    return AppImage(
      id: data['id'],
      originalName: data['original_name'],
      extension: data['extension'],
      urls: data['urls']
    );
  }
}
