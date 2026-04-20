part of 'location_filter_cubit.dart';

@freezed
abstract class LocationFilterState with _$LocationFilterState {
  const factory LocationFilterState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) String? errorText,
    @Default([]) List<Vacancy> listVacancy,
    @Default([]) List<ServiceModel> listService,
    @Default([]) List<TaskModel> listTask,
  }) = _LocationFilterState;
}
