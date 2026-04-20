part of 'vacancy_cubit.dart';

@freezed
abstract class VacancyState with _$VacancyState {
  const factory VacancyState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarVacSt,
    @Default(null) String? errorText,
    //@Default(null) VacancyPaginationResponse? listVacancy,
    @Default(null) VacancyPaginationResponse? listSimilarVacancy,
    @Default(null) PaginationResponse<NewVacancyModel>? newVacancies,
    @Default(false) bool isLoadingMore,
  }) = _VacancyState;
}
