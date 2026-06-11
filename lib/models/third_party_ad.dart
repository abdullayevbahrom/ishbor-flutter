import 'package:equatable/equatable.dart';

import 'api_model_utils.dart';

class ThirdPartyAd extends Equatable {
  final String id;
  final String? title;
  final String? url;
  final String? imageUrl;

  const ThirdPartyAd({required this.id, this.title, this.url, this.imageUrl});

  @override
  List<Object?> get props => [id, title, url, imageUrl];

  factory ThirdPartyAd.fromMap(dynamic source) {
    final map = asMap(source);
    final title = _localizedValue(map['title'] ?? map['name']);
    final image = map['image'] ?? map['image_url'] ?? map['imageUrl'];

    return ThirdPartyAd(
      id: map['id']?.toString() ?? '',
      title: title ?? map['title']?.toString(),
      url: map['url']?.toString(),
      imageUrl: _imageUrl(image),
    );
  }
}

String? _localizedValue(dynamic source) {
  final map = asMap(source);
  if (map.isEmpty) {
    return null;
  }

  for (final key in ['ru', 'uz', 'en']) {
    final value = stringValue(map[key]);
    if (value != null && value.trim().isNotEmpty) {
      return value.trim();
    }
  }

  final firstValue = map.values.isNotEmpty ? map.values.first : null;
  return stringValue(firstValue)?.trim();
}

String? _imageUrl(dynamic source) {
  if (source is String) {
    return source;
  }

  final map = asMap(source);
  if (map.isEmpty) {
    return null;
  }

  return stringValue(
        map['original'] ?? map['url'] ?? map['image_url'] ?? map['imageUrl'],
      ) ??
      _localizedValue(map);
}
