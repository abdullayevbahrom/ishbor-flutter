class SnakeCaseMapper {
  SnakeCaseMapper._();

  static dynamic normalizeValue(dynamic value) {
    if (value is Map) {
      final entries = value.entries.map(
        (entry) => MapEntry(
          normalizeKey(entry.key.toString()),
          normalizeValue(entry.value),
        ),
      ).toList()
        ..sort((left, right) => left.key.compareTo(right.key));

      return Map<String, dynamic>.fromEntries(entries);
    }

    if (value is List) {
      return value.map(normalizeValue).toList();
    }

    return value;
  }

  static Map<String, dynamic> normalizeMap(Map<dynamic, dynamic> value) {
    final normalized = normalizeValue(value);
    if (normalized is Map<String, dynamic>) {
      return normalized;
    }

    return <String, dynamic>{};
  }

  static String normalizeKey(String value) {
    final buffer = StringBuffer();

    for (var index = 0; index < value.length; index++) {
      final char = value[index];
      final isUpperCase = char.toUpperCase() == char &&
          char.toLowerCase() != char;

      if (isUpperCase && index > 0) {
        buffer.write('_');
      }

      buffer.write(char.toLowerCase());
    }

    return buffer.toString().replaceAll('-', '_');
  }

  static Map<String, dynamic> normalizeQuery(Map<dynamic, dynamic> value) =>
      normalizeMap(value);

  static Map<String, dynamic> normalizeBody(Map<dynamic, dynamic> value) =>
      normalizeMap(value);

  static Map<String, dynamic> normalizeFormFields(Map<dynamic, dynamic> value) =>
      normalizeMap(value);
}
