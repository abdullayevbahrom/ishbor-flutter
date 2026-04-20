import 'package:top_jobs/core/helpers/date_time_parser.dart';
import 'package:top_jobs/models/ad_request.dart';
import 'package:top_jobs/models/user.dart';
import 'package:top_jobs/models/vacancy.dart';


class VacancyRequest extends AdRequest {

  final Vacancy vacancy;

  VacancyRequest({
    required id,
    required this.vacancy,
    required performer,
    required status,
    message,
    required createdAt
  }) : super(id: id, performer: performer, status: status, createdAt: createdAt, message: message);

  @override
  List<Object?> get props => [id, vacancy, performer, status, message, createdAt];

  static VacancyRequest fromMap(Map<String, dynamic> data) {
    return VacancyRequest(
      id: data['id'],
      vacancy: Vacancy.fromMap(data['vacancy']),
      performer: User.fromMap(data['performer']),
      status: data['status'],
      message: data['message'] != null ? data['message'] : null,
      createdAt: parseRequiredDateTime(data['created_at']),
    );
  }
}
