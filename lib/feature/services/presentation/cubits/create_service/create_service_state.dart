part of 'create_service_cubit.dart';

@freezed
abstract class CreateServiceState with _$CreateServiceState {
  const factory CreateServiceState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(null) String? errorText,
    @Default(null) ServiceModel? service,
    @Default(false) bool isNegotiable,
    @Default(false) bool isUZS,
    @Default([]) List<File> images,
    @Default(0) int category,
    @Default(null) GeocodeResponse? location
  }) = _CreateServiceState;
}
