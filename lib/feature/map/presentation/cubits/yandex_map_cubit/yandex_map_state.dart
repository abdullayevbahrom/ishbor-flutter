part of 'yandex_map_cubit.dart';

@freezed
abstract class YandexMapState with _$YandexMapState {
  const factory YandexMapState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus searchSt,
    @Default([]) List<String> suggestions,
    @Default(null) response,
    @Default(Point(latitude: 41.311081, longitude: 69.240562)) Point userPoint,
    @Default(false) bool enableFindMe,
    @Default(false) bool isLoading,
    @Default("Chilonzor tumani, Bunyodkor shoh ko'chasi") String addressName,
    String? error,
  }) = _YandexMapState;
}
