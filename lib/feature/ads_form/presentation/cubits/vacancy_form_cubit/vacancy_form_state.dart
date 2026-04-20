part of 'vacancy_form_cubit.dart';

@freezed
abstract class VacancyFormState with _$VacancyFormState {
  const factory VacancyFormState({
    @Default(RequestStatus.initial) RequestStatus gptSt,
    @Default(RequestStatus.initial) RequestStatus gptDesSt,
    @Default(RequestStatus.initial) RequestStatus formSt,
    @Default(null) Vacancy? vacancy,
    @Default(null) VacancyParams? params,
    @Default(false) bool enableForm,
    @Default(false) bool hasUnpublishedAds,
    @Default(false) bool continueUnpublishedAds,
    @Default(null) NewChatGptResponse? vacancyBody,
    @Default(null) String? vacancyDesc,
  }) = _VacancyFormState;
}
