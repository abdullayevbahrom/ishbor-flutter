import 'dart:convert';

class VacancyResponse {
  final bool? ok;
  final JobResult? result;

  VacancyResponse({this.ok, this.result});

  VacancyResponse copyWith({bool? ok, JobResult? result}) =>
      VacancyResponse(ok: ok ?? this.ok, result: result ?? this.result);

  factory VacancyResponse.fromRawJson(String str) =>
      VacancyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VacancyResponse.fromJson(Map<String, dynamic> json) =>
      VacancyResponse(
        ok: json["ok"],
        result:
            json["result"] == null ? null : JobResult.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {"ok": ok, "result": result?.toJson()};
}

class JobResult {
  final String? title;
  final JobCategory? category;
  final String? description;
  final int? salaryMax;
  final int? salaryMin;
  final List<dynamic>? skills;
  final String? shortDescription;
  final JobRespondOption? whoCanRespond;
  final String? employmentType;
  final List? jobModes;
  final bool? partialJobOpportunity;
  final String? city;
  final List<JobAddress>? address;

  JobResult({
    this.title,
    this.category,
    this.description,
    this.salaryMax,
    this.salaryMin,
    this.skills,
    this.shortDescription,
    this.whoCanRespond,
    this.employmentType,
    this.jobModes,
    this.partialJobOpportunity,
    this.city,
    this.address,
  });

  factory JobResult.fromJson(Map<String, dynamic> json) => JobResult(
    title: json["title"],
    category: json["category"] == null
        ? null
        : JobCategory.fromJson(json["category"]),
    description: json["description"],
    salaryMax: json["salaryMax"],
    salaryMin: json["salaryMin"],
    skills: json["skills"] == null ? [] : List.from(json["skills"]),
    shortDescription: json["shortDescription"],
    whoCanRespond: json["whoCanRepond"] == null
        ? null
        : JobRespondOption.fromJson(json["whoCanRepond"]),
    employmentType: json["employmentType"],
    jobModes: json["jobModes"] == null ? [] : List.from(json["jobModes"]),
    partialJobOpportunity: json["partialJobOpportunity"],
    city: json["city"],
    address: json["address"] == null
        ? []
        : List<JobAddress>.from(json["address"].map((x) => JobAddress.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "category": category?.toJson(),
    "description": description,
    "salaryMax": salaryMax,
    "salaryMin": salaryMin,
    "skills": skills,
    "shortDescription": shortDescription,
    "whoCanRepond": whoCanRespond?.toJson(),
    "employmentType": employmentType,
    "jobModes": jobModes,
    "partialJobOpportunity": partialJobOpportunity,
    "city": city,
    "address": address?.map((x) => x.toJson()).toList(),
  };
}

class JobRespondOption {
  final int? id;
  final String? name;

  JobRespondOption({this.id, this.name});

  factory JobRespondOption.fromJson(Map<String, dynamic> json) => JobRespondOption(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
class JobCategory {
  final int? id;
  final String? name;

  JobCategory({this.id, this.name});

  JobCategory copyWith({int? id, String? name}) =>
      JobCategory(id: id ?? this.id, name: name ?? this.name);

  factory JobCategory.fromJson(Map<String, dynamic> json) =>
      JobCategory(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class JobAddress {
  final String? addressLine;

  JobAddress({this.addressLine});

  JobAddress copyWith({String? addressLine}) =>
      JobAddress(addressLine: addressLine ?? this.addressLine);

  factory JobAddress.fromJson(Map<String, dynamic> json) =>
      JobAddress(addressLine: json["addressLine"]);

  Map<String, dynamic> toJson() => {"addressLine": addressLine};
}
