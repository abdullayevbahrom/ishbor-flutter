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
    return TagModel(
      id: stringValue(map['id']) ?? '',
      name: stringValue(map['name'] ?? map['title']) ?? '',
    );
  }
}
