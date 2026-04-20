part of 'service_cubit.dart';

@freezed
abstract class ServiceState with _$ServiceState {
  const factory ServiceState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarServiceSt,
    @Default(null) String? errorText,
    @Default(null) PaginatedServiceResponse? listService,
    @Default(null) PaginatedServiceResponse? listSimilarService,
    @Default(false) bool isLoadingMore
  }) = _ServiceState;
}
