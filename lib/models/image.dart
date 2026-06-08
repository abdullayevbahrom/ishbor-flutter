import 'package:equatable/equatable.dart';

class AppImage extends Equatable {
  final String? id;
  final String? originalName;
  final String? extension;
  final Map<String, dynamic> urls;

  const AppImage({
    required this.id,
    required this.originalName,
    required this.extension,
    required this.urls,
  });

  @override
  List<Object?> get props => [id, originalName, extension, urls];

  static AppImage fromMap(Map<String, dynamic> data) {
    return AppImage.fromJson(data);
  }

  static AppImage fromJson(dynamic source) {
    if (source is String) {
      return AppImage(
        id: null,
        originalName: null,
        extension: null,
        urls: {'original': source},
      );
    }

    final data = source is Map<String, dynamic>
        ? Map<String, dynamic>.from(source)
        : source is Map
            ? Map<String, dynamic>.fromEntries(
                source.entries.map(
                  (entry) => MapEntry(entry.key.toString(), entry.value),
                ),
              )
            : <String, dynamic>{};

    final urls = data['urls'];
    return AppImage(
      id: data['id']?.toString(),
      originalName: data['original_name']?.toString(),
      extension: data['extension']?.toString(),
      urls: urls is Map<String, dynamic>
          ? Map<String, dynamic>.from(urls)
          : urls is Map
              ? Map<String, dynamic>.fromEntries(
                  urls.entries.map(
                    (entry) => MapEntry(entry.key.toString(), entry.value),
                  ),
                )
              : data['url'] == null
                  ? <String, dynamic>{}
                  : {'original': data['url']},
    );
  }
}

typedef ApiImage = AppImage;
