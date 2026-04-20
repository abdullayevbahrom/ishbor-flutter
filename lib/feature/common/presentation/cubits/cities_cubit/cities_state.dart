part of 'cities_cubit.dart';

@freezed
abstract class CitiesState with _$CitiesState {
  const factory CitiesState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) String? errorText,
    @Default(null) CitiesList? listCities,
  }) = _CitiesState;
}
