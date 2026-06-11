Map<String, dynamic> unwrapData(dynamic source) {
  final data = asMap(source);
  final payload = data['data'];

  if (payload != null) {
    return asMap(payload);
  }

  return data;
}

Map<String, dynamic> asMap(dynamic source) {
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

List<T> mappedList<T>(dynamic value, T Function(dynamic source) mapper) {
  if (value is! List) {
    return <T>[];
  }

  return value.map(mapper).toList(growable: false);
}

List<String>? stringList(dynamic value) {
  if (value is! List) {
    return null;
  }

  return value.map((item) => item.toString()).toList(growable: false);
}

String? stringValue(dynamic value) {
  if (value == null) {
    return null;
  }

  return value.toString();
}

int? intValue(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString());
}

double? doubleValue(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is double) {
    return value;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString());
}

bool? boolValue(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is bool) {
    return value;
  }

  if (value is num) {
    return value != 0;
  }

  final normalized = value.toString().toLowerCase().trim();
  if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
    return true;
  }
  if (normalized == 'false' || normalized == '0' || normalized == 'no') {
    return false;
  }

  return null;
}

DateTime? dateTimeValue(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is DateTime) {
    return value;
  }

  return DateTime.tryParse(value.toString());
}
