part of 'other_profile_cubit.dart';

@freezed
abstract class OtherProfileState with _$OtherProfileState {
  const factory OtherProfileState({
    @Default(null) int? userId,
    @Default(0) int index,
    @Default(RequestStatus.initial) RequestStatus vacancy,
    @Default(RequestStatus.initial) RequestStatus service,
    @Default(RequestStatus.initial) RequestStatus task,
    @Default(null) VacancyPaginationResponse? listVacancy,
    @Default(null) PaginatedServiceResponse? listService,
    @Default(null) PaginatedTaskListResponse? listTask,
    @Default(null) String? vacancyError,
    @Default(null) String? serviceError,
    @Default(null) String? taskError,
  }) = _OtherProfileState;
}
