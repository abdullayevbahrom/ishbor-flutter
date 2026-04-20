part of 'service_view_cubit.dart';

@freezed
abstract class ServiceViewState with _$ServiceViewState {
  const factory ServiceViewState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus similarServiceSt,
    @Default(false) bool isLoadingMore,
    @Default(null) ServiceModel? service,
    @Default(null) PaginatedServiceResponse? listService,
    @Default(null) int? serviceId

}) = _ServiceViewState;
}
