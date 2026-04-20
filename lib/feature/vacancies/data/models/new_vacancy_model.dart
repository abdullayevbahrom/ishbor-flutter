// All fields are nullable
// Model name: NewVacancyModel
// Includes: fromJson / toJson / copyWith

class NewVacancyModel {
  final int? id;
  final String? title;
  final String? titleUz;
  final String? titleRu;
  final String? description;
  final String? descriptionUz;
  final String? descriptionRu;
  final String? city;
  final DateTime? createdAt;
  final bool? isFavorite;
  final bool? isTop;
  final String? status;
  final VacancyCustomer? customer;
  final String? imageUrl;
  final double? salaryMin;
  final double? salaryMax;

  const NewVacancyModel({
    this.id,
    this.title,
    this.titleUz,
    this.titleRu,
    this.description,
    this.descriptionUz,
    this.descriptionRu,
    this.city,
    this.createdAt,
    this.isFavorite,
    this.isTop,
    this.status,
    this.customer,
    this.imageUrl,
    this.salaryMin,
    this.salaryMax,
  });

  NewVacancyModel copyWith({
    int? id,
    String? title,
    String? titleUz,
    String? titleRu,
    String? description,
    String? descriptionUz,
    String? descriptionRu,
    String? city,
    DateTime? createdAt,
    bool? isFavorite,
    bool? isTop,
    String? status,
    VacancyCustomer? customer,
    String? imageUrl,
    double? salaryMin,
    double? salaryMax,
  }) {
    return NewVacancyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      titleUz: titleUz ?? this.titleUz,
      titleRu: titleRu ?? this.titleRu,
      description: description ?? this.description,
      descriptionUz: descriptionUz ?? this.descriptionUz,
      descriptionRu: descriptionRu ?? this.descriptionRu,
      city: city ?? this.city,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      isTop: isTop ?? this.isTop,
      status: status ?? this.status,
      customer: customer ?? this.customer,
      imageUrl: imageUrl ?? this.imageUrl,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
    );
  }

  factory NewVacancyModel.fromJson(Map<String, dynamic> json) {
    return NewVacancyModel(
      id: _asInt(json['id']),
      title: _asString(json['title']),
      titleUz: _asString(json['title_uz']),
      titleRu: _asString(json['title_ru']),
      description: _asString(json['description']),
      descriptionUz: _asString(json['description_uz']),
      descriptionRu: _asString(json['description_ru']),
      city: _asString(json['city']),
      createdAt: _asDateTime(json['created_at']),
      isFavorite: _asBool(json['is_favorite']),
      isTop: _asBool(json['is_top']),
      status: _asString(json['status']),
      customer:
          json['customer'] is Map<String, dynamic>
              ? VacancyCustomer.fromJson(json['customer'])
              : null,
      imageUrl: _asString(json['image_url']),
      salaryMin: _asDouble(json['salary_min']),
      salaryMax: _asDouble(json['salary_max']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'title_uz': titleUz,
      'title_ru': titleRu,
      'description': description,
      'description_uz': descriptionUz,
      'description_ru': descriptionRu,
      'city': city,
      'created_at': createdAt?.toUtc().toIso8601String(),
      'is_favorite': isFavorite,
      'is_top': isTop,
      'status': status,
      'customer': customer?.toJson(),
      'image_url': imageUrl,
      'salary_min': salaryMin,
      'salary_max': salaryMax,
    };
  }

  // ---------- helpers ----------
  static String? _asString(dynamic v) {
    if (v == null) return null;
    if (v is String) return v;
    return v.toString();
  }

  static int? _asInt(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v);
    return null;
  }

  static double? _asDouble(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }

  static bool? _asBool(dynamic v) {
    if (v == null) return null;
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase().trim();
      if (s == 'true' || s == '1' || s == 'yes') return true;
      if (s == 'false' || s == '0' || s == 'no') return false;
    }
    return null;
  }

  static DateTime? _asDateTime(dynamic v) {
    if (v == null) return null;
    if (v is DateTime) return v;
    if (v is String) return DateTime.tryParse(v);
    return null;
  }
}

class VacancyCustomer {
  final int? id;
  final String? fullName;
  final bool? documentVerified;
  final String? imageUrl;

  const VacancyCustomer({
    this.id,
    this.fullName,
    this.documentVerified,
    this.imageUrl,
  });

  VacancyCustomer copyWith({
    int? id,
    String? fullName,
    bool? documentVerified,
    String? imageUrl,
  }) {
    return VacancyCustomer(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      documentVerified: documentVerified ?? this.documentVerified,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  factory VacancyCustomer.fromJson(Map<String, dynamic> json) {
    return VacancyCustomer(
      id: NewVacancyModel._asInt(json['id']),
      fullName: NewVacancyModel._asString(json['full_name']),
      documentVerified: NewVacancyModel._asBool(json['document_verified']),
      imageUrl: NewVacancyModel._asString(json['image_url']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'document_verified': documentVerified,
      'image_url': imageUrl,
    };
  }
}
