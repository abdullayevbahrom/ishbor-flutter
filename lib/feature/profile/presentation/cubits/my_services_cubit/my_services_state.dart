part of 'my_services_cubit.dart';

@freezed
abstract class MyServicesState with _$MyServicesState {
  const factory MyServicesState({
    @Default(RequestStatus.initial) RequestStatus myServicesSt,
    @Default(RequestStatus.initial) RequestStatus myServicesAppliesSt,
    @Default(RequestStatus.initial) RequestStatus liftUpSt,
    @Default(RequestStatus.initial) RequestStatus deleteSt,
    @Default(false) bool isLadingMore1,
    @Default(false) bool isLadingMore2,
    @Default(RequestStatus.initial) RequestStatus deactivateSt,
    @Default(null) PaginatedServiceResponse? myServices,
    @Default(null) PaginatedServiceResponse? myServicesApplies,
    @Default(null) String? errorText,
  }) = _MyServicesState;
}
