import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_view_repository.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';

import '../../../../services/data/models/service.dart';

part 'service_view_state.dart';

part 'service_view_cubit.freezed.dart';

class ServiceViewCubit extends Cubit<ServiceViewState> {
  ServiceViewCubit(this._adsViewRepository, this._serviceRepository)
    : super(const ServiceViewState());
  final AdsViewRepository _adsViewRepository;
  final ServiceRepository _serviceRepository;

  int size = 10;
  int page = 1;

  void fetchData(int serviceId) {
    reset();
    fetchServiceById(serviceId);
    fetchSimilarServices();
  }

  void reset() {
    page = 1;
  }

  Future<void> fetchServiceById(int serviceId) async {
    emit(state.copyWith(status: RequestStatus.loading, serviceId: serviceId));
    final response = await _adsViewRepository.fetchServiceById(
      serviceId: serviceId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, service: r));
      },
    );
  }

  Future<void> toggleService() async {
    final newService = state.service?.copyWith(
      isFavorite: !(state.service?.isFavorite ?? false),
    );

    emit(state.copyWith(service: newService));
    await _serviceRepository.toggleServiceById(serviceId: state.service!.id);
  }

  Future<void> fetchSimilarServices() async {
    emit(state.copyWith(similarServiceSt: RequestStatus.loading));
    final response = await _serviceRepository.fetchSimilarServices(
      queryParams: CommonQueryParams(
        id: state.serviceId,
        pageNumber: page,
        pageSize: size,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(similarServiceSt: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(
            similarServiceSt: RequestStatus.loaded,
            listService: r,
          ),
        );
      },
    );
  }

  void checkLoadMoreData() {
    if (!state.isLoadingMore) {
      if (state.listService?.totalCount != state.listService?.items.length) {
        increasePage();
      }
    }
  }

  void increasePage() {
    page += 1;
  }

  Future<void> fetchMoreSimilarServices() async {
    emit(state.copyWith(isLoadingMore: true));
    final response = await _serviceRepository.fetchSimilarServices(
      queryParams: CommonQueryParams(
        id: state.serviceId,
        pageSize: size,
        pageNumber: page,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (r) {
        emit(
          state.copyWith(
            similarServiceSt: RequestStatus.loaded,
            isLoadingMore: false,
            listService: r.copyWith(
              items: [...state.listService?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }
}
