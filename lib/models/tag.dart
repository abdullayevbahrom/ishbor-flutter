import 'package:equatable/equatable.dart';

import 'api_model_utils.dart';

class TagModel extends Equatable {
  final String id;
  final String name;

  const TagModel({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  factory TagModel.fromMap(dynamic source) {
    if (source is String) {
      return TagModel(id: source, name: source);
    }

    final map = unwrapData(source);
    final name =
        _localizedName(map['name'] ?? map['title']) ??
        stringValue(map['name'] ?? map['title']) ??
        '';
    return TagModel(id: stringValue(map['id']) ?? '', name: name);
  }
}

String? _localizedName(dynamic source) {
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
