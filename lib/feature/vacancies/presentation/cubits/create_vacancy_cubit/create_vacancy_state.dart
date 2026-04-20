part of 'create_vacancy_cubit.dart';

@freezed
abstract class CreateVacancyState with _$CreateVacancyState {
  const factory CreateVacancyState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus createVacSt,
    @Default(RequestStatus.initial) RequestStatus generateVacancyDes,
    @Default(null) String? errorText,
    @Default({}) Set operatingMode,
    @Default(3) int employmentType,
    @Default(true) bool withOutResume,
    @Default(false) bool temporaryEmployee,
    @Default(false) bool buttonEnable,
    @Default(false) bool salaryInInterview,
    @Default(false) bool uzsCurrency,
    @Default(null) Vacancy? vacancy,
    @Default(false) bool isEnable,
    @Default(null) GeocodeResponse? location,
    @Default([]) List<File> images,
    @Default(null) int? category
  }) = _CreateVacancyState;
}
