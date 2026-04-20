part of 'location_info_cubit.dart';

@freezed
abstract class LocationInfoState with _$LocationInfoState {
  const factory LocationInfoState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus suggestionStatus,
    @Default(null) String? errorText,
    @Default(null) LocationInfo? locationInfo,
    @Default(LatLng(41.311081, 69.230562)) LatLng defaultCenter,
    @Default([]) List<SuggestedLocation> suggestions,
  }) = _LocationInfoState;
}
