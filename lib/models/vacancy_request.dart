import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_request.dart';
import 'package:top_jobs/models/user.dart';
import 'package:top_jobs/models/vacancy.dart';

class VacancyRequest extends AdRequest {
  final Vacancy vacancy;

  const VacancyRequest({
    required super.id,
    required this.vacancy,
    required super.performer,
    required super.status,
    super.message,
    required super.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    vacancy,
    performer,
    status,
    message,
    createdAt,
  ];

  static VacancyRequest fromMap(Map<String, dynamic> data) {
    return VacancyRequest(
      id: data['id']?.toString() ?? '',
      vacancy: Vacancy.fromMap(data['vacancy']),
      performer: User.fromMap(data['performer']),
      status: data['status']?.toString() ?? '',
      message: data['message']?.toString(),
      createdAt: parseRequiredDateTime(data['created_at']),
    );
  }
}
