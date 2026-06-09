part of 'vacancy_requests_cubit.dart';

@freezed
abstract class VacancyRequestsState with _$VacancyRequestsState {
  const factory VacancyRequestsState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus changeStatusSt,
    @Default(null) PaginatedVacancyRequestList? listVacancyRequest,
    @Default(null) Vacancy? vacancy,
    @Default(null) VacancyRequest? vacancyRequest,
  }) = _VacancyRequestsState;
}
