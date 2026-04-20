import 'dart:convert';
/// Job posting model built from numeric-keyed JSON.
class ChatGptResponse {
  /// 1: "Savdo agenti, haydovchi va sklad mudiri"
  final String title;

  /// 2: 2 (yil tajriba)
  final int? experienceYears;

  /// 3: 5_000_000 (so'm)
  final int? salaryFrom;

  /// 4: 10_000_000 (so'm)
  final int? salaryTo;

  /// 5: ["savdo ko'nikmalari", "haydovchilik", ...]
  final List<String> skills;

  /// 6: Kompaniya haqida matn
  final String? companyDescription;

  /// 7: Domen-spesifik flag (namunada 1). Aniq ma’nosi kontekstga bog‘liq.
  final int? flag7;

  /// 8: Domen-spesifik flag (namunada 1). Aniq ma’nosi kontekstga bog‘liq.
  final int? flag8;

  /// 9: Qo‘shimcha imtiyozlar ro‘yxati (namunada bo‘sh).
  final List<String> benefits;

  /// 10: Viloyat, masalan: "Surxondaryo viloyati"
  final String? region;

  /// 11: Tumanlar ro‘yxati (stringdan ajratib tozalab olingan)
  final List<String> districts;

  const ChatGptResponse({
    required this.title,
    this.experienceYears,
    this.salaryFrom,
    this.salaryTo,
    this.skills = const [],
    this.companyDescription,
    this.flag7,
    this.flag8,
    this.benefits = const [],
    this.region,
    this.districts = const [],
  });

  /// Manual mapping from numeric-key JSON.
  factory ChatGptResponse.fromJson(Map<String, dynamic> json) {
    // "11" may come either as List or a single comma-separated String.
    List<String> parseDistricts(dynamic v) {
      if (v == null) return const [];
      if (v is List) {
        return v.map((e) => e?.toString().trim() ?? '').where((e) => e.isNotEmpty).toList();
      }
      if (v is String) {
        return v
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();
      }
      return const [];
    }

    List<String> parseStringList(dynamic v) {
      if (v is List) {
        return v.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
      }
      return const [];
    }

    return ChatGptResponse(
      title: json['1']?.toString() ?? '',
      experienceYears: (json['2'] is num) ? (json['2'] as num).toInt() : int.tryParse(json['2']?.toString() ?? ''),
      salaryFrom: (json['3'] is num) ? (json['3'] as num).toInt() : int.tryParse(json['3']?.toString() ?? ''),
      salaryTo: (json['4'] is num) ? (json['4'] as num).toInt() : int.tryParse(json['4']?.toString() ?? ''),
      skills: parseStringList(json['5']),
      companyDescription: json['6']?.toString(),
      flag7: (json['7'] is num) ? (json['7'] as num).toInt() : int.tryParse(json['7']?.toString() ?? ''),
      flag8: (json['8'] is num) ? (json['8'] as num).toInt() : int.tryParse(json['8']?.toString() ?? ''),
      benefits: parseStringList(json['9']),
      region: json['10']?.toString(),
      districts: parseDistricts(json['11']),
    );
  }

  /// Back to the original numeric-key JSON shape.
  Map<String, dynamic> toJson() {
    return {
      '1': title,
      '2': experienceYears,
      '3': salaryFrom,
      '4': salaryTo,
      '5': skills,
      '6': companyDescription,
      '7': flag7,
      '8': flag8,
      '9': benefits,
      '10': region,
      '11': districts,
    };
  }

  ChatGptResponse copyWith({
    String? title,
    int? experienceYears,
    int? salaryFrom,
    int? salaryTo,
    List<String>? skills,
    String? companyDescription,
    int? flag7,
    int? flag8,
    List<String>? benefits,
    String? region,
    List<String>? districts,
  }) {
    return ChatGptResponse(
      title: title ?? this.title,
      experienceYears: experienceYears ?? this.experienceYears,
      salaryFrom: salaryFrom ?? this.salaryFrom,
      salaryTo: salaryTo ?? this.salaryTo,
      skills: skills ?? this.skills,
      companyDescription: companyDescription ?? this.companyDescription,
      flag7: flag7 ?? this.flag7,
      flag8: flag8 ?? this.flag8,
      benefits: benefits ?? this.benefits,
      region: region ?? this.region,
      districts: districts ?? this.districts,
    );
  }

  @override
  String toString() {
    return 'JobPosting(title: $title, exp: $experienceYears, salary: $salaryFrom-$salaryTo, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatGptResponse &&
        other.title == title &&
        other.experienceYears == experienceYears &&
        other.salaryFrom == salaryFrom &&
        other.salaryTo == salaryTo &&
        _listEquals(other.skills, skills) &&
        other.companyDescription == companyDescription &&
        other.flag7 == flag7 &&
        other.flag8 == flag8 &&
        _listEquals(other.benefits, benefits) &&
        other.region == region &&
        _listEquals(other.districts, districts);
  }

  @override
  int get hashCode =>
      title.hashCode ^
      (experienceYears ?? 0).hashCode ^
      (salaryFrom ?? 0).hashCode ^
      (salaryTo ?? 0).hashCode ^
      skills.hashCode ^
      (companyDescription ?? '').hashCode ^
      (flag7 ?? 0).hashCode ^
      (flag8 ?? 0).hashCode ^
      benefits.hashCode ^
      (region ?? '').hashCode ^
      districts.hashCode;

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}


class NewChatGptResponse {
  final bool ok;
  final Result result;

  NewChatGptResponse({
    required this.ok,
    required this.result,
  });

  NewChatGptResponse copyWith({
    bool? ok,
    Result? result,
  }) {
    return NewChatGptResponse(
      ok: ok ?? this.ok,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ok': ok,
      'result': result.toMap(),
    };
  }

  factory NewChatGptResponse.fromMap(Map<String, dynamic> map) {
    return NewChatGptResponse(
      ok: map['ok'] as bool,
      result: Result.fromMap(map['result'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewChatGptResponse.fromJson(String source) =>
      NewChatGptResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ApiResponse(ok: $ok, result: $result)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NewChatGptResponse && other.ok == ok && other.result == result;
  }

  @override
  int get hashCode => ok.hashCode ^ result.hashCode;
}

class Result {
  final String? title;
  final Category?  category;
  final int? salaryMin;
  final int? salaryMax;
  final List<String?> phoneNumbers;

  Result({
    required this.title,
    required this.category,
    required this.salaryMin,
    required this.salaryMax,
    required this.phoneNumbers,
  });

  Result copyWith({
    String? title,
    Category? category,
    int? salaryMin,
    int? salaryMax,
    List<String>? phoneNumbers,
  }) {
    return Result(
      title: title ?? this.title,
      category: category ?? this.category,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      phoneNumbers: phoneNumbers ?? List<String>.from(this.phoneNumbers),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'category': category?.toMap(),
      'salaryMin': salaryMin,
      'salaryMax': salaryMax,
      'phone_numbers': phoneNumbers,
    };
  }

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      title: map['title'] as String?,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      salaryMin: (map['salaryMin'] as num?)?.toInt(),
      salaryMax: (map['salaryMax'] as num?)?.toInt(),
      phoneNumbers: map['phone_numbers'] == null
          ? <String>[]
          : List<String?>.from(map['phone_numbers'] as List),
    );
  }

  String toJson() => json.encode(toMap());

  factory Result.fromJson(String source) =>
      Result.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Result(title: $title, category: $category, salaryMin: $salaryMin, salaryMax: $salaryMax, phoneNumbers: $phoneNumbers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Result &&
        other.title == title &&
        other.category == category &&
        other.salaryMin == salaryMin &&
        other.salaryMax == salaryMax &&
        _listEquals(other.phoneNumbers, phoneNumbers);
  }

  @override
  int get hashCode =>
      title.hashCode ^
      category.hashCode ^
      salaryMin.hashCode ^
      salaryMax.hashCode ^
      phoneNumbers.hashCode;
}

class Category {
  final int id;

  Category({required this.id});

  Category copyWith({int? id}) {
    return Category(id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return {'id': id};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(id: (map['id'] as num).toInt());
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Category(id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

/// Yordamchi: List tengligini tekshirish (eng oddiy implementatsiya)
bool _listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null && b == null) return true;
  if (a == null || b == null) return false;
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
