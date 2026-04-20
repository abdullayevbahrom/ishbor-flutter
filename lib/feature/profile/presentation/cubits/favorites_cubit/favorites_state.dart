part of 'favorites_cubit.dart';

@freezed
abstract class FavoritesState with _$FavoritesState {
  const factory FavoritesState({
    @Default(RequestStatus.initial) RequestStatus vacancyStatus,
    @Default(RequestStatus.initial) RequestStatus serviceStatus,
    @Default(RequestStatus.initial) RequestStatus taskStatus,
    @Default([]) List<Vacancy> listVacancy,
    @Default([]) List<ServiceModel> listService,
    @Default([]) List<TaskModel> listTAsk,
  }) = _FavoritesState;
}
