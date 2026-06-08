import 'package:equatable/equatable.dart';
import 'package:top_jobs/models/image.dart';
import 'package:top_jobs/models/localized_text.dart';

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
    final raw = _asMap(source);
    return AdCustomer(
      raw: raw,
      id: _asString(raw['id']),
      fullName: _asString(raw['full_name'] ?? raw['fullName']),
      phoneNumber: _asString(raw['phone_number'] ?? raw['phoneNumber']),
      city: _asString(raw['city']),
      locale: _asString(raw['locale']),
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

  return <String, dynamic>{};
}

String? _asString(dynamic value) =>
    value?.toString();

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
