part of 'vacancy_view_cubit.dart';

@freezed
abstract class VacancyViewState with _$VacancyViewState {
  const factory VacancyViewState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarVacanciesSt,
    @Default(false) bool isLoadingMore,
    @Default(null) VacancyPaginationResponse? listSimilarVacancy,
    @Default(null) Vacancy? vacancy,
    @Default(null ) int? vacancyId
}) = _VacancyViewState;

}
