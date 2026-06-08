class LocalizedText {
  final String? uz;
  final String? ru;
  final String? en;
  final Map<String, dynamic> raw;

  const LocalizedText({
    required this.raw,
    this.uz,
    this.ru,
    this.en,
  });

  factory LocalizedText.fromJson(dynamic source) {
    if (source is String) {
      return LocalizedText(raw: <String, dynamic>{'value': source}, uz: source);
    }

    if (source is Map<String, dynamic>) {
      return LocalizedText(
        raw: Map<String, dynamic>.from(source),
        uz: _asString(source['uz']),
        ru: _asString(source['ru']),
        en: _asString(source['en']),
      );
    }

    if (source is Map) {
      final raw = Map<String, dynamic>.fromEntries(
        source.entries.map(
          (entry) => MapEntry(entry.key.toString(), entry.value),
        ),
      );
      return LocalizedText(
        raw: raw,
        uz: _asString(raw['uz']),
        ru: _asString(raw['ru']),
        en: _asString(raw['en']),
      );
    }

    return const LocalizedText(raw: <String, dynamic>{});
  }

  String? resolve([String? localeCode]) {
    switch (localeCode) {
      case 'uz':
        return uz ?? ru ?? en;
      case 'ru':
        return ru ?? uz ?? en;
      case 'en':
        return en ?? uz ?? ru;
    }

    return uz ?? ru ?? en;
  }

  static String? _asString(dynamic value) =>
      value?.toString();
}
