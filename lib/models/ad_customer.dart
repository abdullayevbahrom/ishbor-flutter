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
        source is String ? <String, dynamic>{'id': source} : unwrapData(source);
    return AdCustomer(
      raw: raw,
      id: stringValue(raw['id']),
      fullName: _fullName(raw),
      phoneNumber: _phoneNumber(raw),
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
  String get displayName =>
      (fullName ?? '').trim().isNotEmpty
          ? fullName!.trim()
          : (phoneNumber ?? '').trim().isNotEmpty
          ? phoneNumber!.trim()
          : 'Noma\'lum';

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

String? _fullName(Map<String, dynamic> raw) {
  final nestedCustomer = raw['customer'];
  if (nestedCustomer is Map) {
    final nested = Map<String, dynamic>.fromEntries(
      nestedCustomer.entries.map(
        (entry) => MapEntry(entry.key.toString(), entry.value),
      ),
    );
    final nestedName = _fullName(nested);
    if (nestedName != null && nestedName.trim().isNotEmpty) {
      return nestedName.trim();
    }
  }

  final direct =
      stringValue(raw['full_name'] ?? raw['fullName'] ?? raw['name'])?.trim();
  if (direct != null && direct.isNotEmpty) {
    return direct;
  }

  final middleName =
      stringValue(raw['middle_name'] ?? raw['middleName'])?.trim() ?? '';
  final firstName =
      stringValue(raw['first_name'] ?? raw['firstName'])?.trim() ?? '';
  final lastName =
      stringValue(raw['last_name'] ?? raw['lastName'])?.trim() ?? '';
  final combined = '$firstName $middleName $lastName'.trim();
  if (combined.isNotEmpty) {
    return combined;
  }

  return null;
}

String? _phoneNumber(Map<String, dynamic> raw) {
  final nestedCustomer = raw['customer'];
  if (nestedCustomer is Map) {
    final nested = Map<String, dynamic>.fromEntries(
      nestedCustomer.entries.map(
        (entry) => MapEntry(entry.key.toString(), entry.value),
      ),
    );
    final nestedPhone = _phoneNumber(nested);
    if (nestedPhone != null && nestedPhone.trim().isNotEmpty) {
      return nestedPhone.trim();
    }
  }

  return stringValue(raw['phone_number'] ?? raw['phoneNumber'])?.trim();
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
