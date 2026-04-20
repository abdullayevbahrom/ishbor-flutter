part of 'map_view_cubit.dart';

@freezed
abstract class MapViewState with _$MapViewState {
  const factory MapViewState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(false) bool enableCurrentLoc,
    @Default(Point(latitude: 41.311081, longitude: 69.240562)) Point userPoint,
    @Default([]) List<Vacancy> listVacancy,
    @Default([]) List<ServiceModel> listService,
    @Default([]) List<TaskModel> listTask,
    @Default([]) List<CategoryModel> categories,
    @Default(null) Point? point,
    @Default(null) String? type,
    @Default(null) MapObjectId? selectedMapObjects,
    @Default([]) List<Vacancy> selectedVacancies,
    @Default([]) List<ServiceModel> selectedServices,
    @Default([]) List<TaskModel> selectedTasks,
  }) = _MapViewState;
}
