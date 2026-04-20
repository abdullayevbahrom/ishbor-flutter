part of 'my_vacancies_cubit.dart';

@freezed
abstract class MyVacanciesState with _$MyVacanciesState {
  const factory MyVacanciesState({
    @Default(RequestStatus.initial) RequestStatus vacanciesSt,
    @Default(RequestStatus.initial) RequestStatus appliedVacanciesSt,
    @Default(RequestStatus.initial) RequestStatus liftUpSt,
    @Default(RequestStatus.initial) RequestStatus deleteSt,
    @Default(RequestStatus.initial) RequestStatus deactivateSt,
    @Default(false) bool isLoadingMore1,
    @Default(false) bool isLoadingMore2,
    @Default(null) VacancyPaginationResponse? myVacancies,
    @Default(null) VacancyPaginationResponse? myAppliedVacancies,
    @Default(null) String? errorText,
  }) = _MyVacanciesState;
}
