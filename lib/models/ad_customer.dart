import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';

import 'api_model_utils.dart';

class AdCustomer extends Equatable {
  final String? id;
  final String? fullName;
  final String? phoneNumber;
  final String? city;
  final String? locale;
  final AppImage? avatar;
  final LocalizedText? title;
  final Map<String, dynamic> raw;

  const AdCustomer({
    required this.raw,
    this.id,
    this.fullName,
    this.phoneNumber,
    this.city,
    this.locale,
    this.avatar,
    this.title,
  });

  factory AdCustomer.fromJson(dynamic source) {
    final raw =
        source is String
            ? <String, dynamic>{'id': source}
            : unwrapData(source);
    return AdCustomer(
      raw: raw,
      id: stringValue(raw['id']),
      fullName: stringValue(raw['full_name'] ?? raw['fullName']),
      phoneNumber: stringValue(raw['phone_number'] ?? raw['phoneNumber']),
      city: stringValue(raw['city']),
      locale: stringValue(raw['locale']),
      avatar: _asAppImage(raw['avatar']),
      title: _asLocalizedText(raw['title']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    phoneNumber,
    city,
    locale,
    avatar,
    title,
  ];

  int get likesCount => _intFromRaw('likes_count');
  int get dislikesCount => _intFromRaw('dislikes_count');
  bool? get documentVerified => _boolFromRaw('document_verified');

  int _intFromRaw(String key) {
    final value = raw[key];
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  bool? _boolFromRaw(String key) {
    final value = raw[key];
    if (value is bool) {
      return value;
    }
    if (value is num) {
      return value != 0;
    }
    if (value is String) {
      return value == 'true';
    }
    return null;
  }
}

AppImage? _asAppImage(dynamic value) {
  if (value is String || value is Map) {
    return AppImage.fromJson(value);
  }

  return null;
}

LocalizedText? _asLocalizedText(dynamic value) {
  if (value is String || value is Map) {
    return LocalizedText.fromJson(value);
  }

  return null;
}
