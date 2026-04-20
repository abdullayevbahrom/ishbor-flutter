import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../main/presentation/cubit/main_cubit/main_cubit.dart';
import '../../../data/models/service.dart';

part 'service_state.dart';

part 'service_cubit.freezed.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit(this._serviceRepository) : super(const ServiceState());
  final searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ServiceRepository _serviceRepository;
  bool _isInitialized = false;

  QueryParams _filters = QueryParams.empty();

  QueryParams get filters => _filters;

  int pageNumber = 1;
  int pageSize = 10;

  void resetFilter() {
    _filters = QueryParams.empty();
    reset();

  }

  void updateFilter(QueryParams queryParams) {
    _filters = queryParams;
    reset();
    fetchServices();
  }

  void reset() {
    pageNumber = 1;

  }

  void initialize() {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (navigatorKey.currentContext?.read<MainCubit>().state.isOpen ?? false) {
      navigatorKey.currentContext?.read<MainCubit>().updateOpen(false);
    }

    if (navigatorKey.currentContext?.read<MainCubit>().state.isNotificationMenuOpen ??
        false) {
      navigatorKey.currentContext?.read<MainCubit>().updateNtfMenu(false);
    }
    if (maxScroll - currentScroll < 20 && !state.isLoadingMore) {
      if (state.listService?.items.length != state.listService?.totalCount) {
        increasePageNumber();
        fetchMoreServices();
      }
    }
  }

  void increasePageNumber() {
    pageNumber += 1;
  }

  Future<void> fetchServices() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _serviceRepository.fetchServices(
      queryParams: QueryParams(
        size: pageSize,
        page: pageNumber,
        title: searchController.text.trim(),
        categories: _filters.categories,
        employmentTypes: _filters.employmentTypes,
        city: _filters.city,
        priceMin: _filters.priceMin,
      ),
    );
    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listService: r));
      },
    );
  }

  Future<void> fetchMoreServices() async {
    emit(state.copyWith(isLoadingMore: true));

    final response = await _serviceRepository.fetchServices(
      queryParams: QueryParams(
        size: pageSize,
        page: pageNumber,
        title: searchController.text.trim(),
        categories: _filters.categories,
        employmentTypes: _filters.employmentTypes,
        city: _filters.city,
        priceMin: _filters.priceMin,
      ),
    );
    response.fold(
      (l) {
        emit(
          state.copyWith(
            status: RequestStatus.error,
            isLoadingMore: false,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            isLoadingMore: false,
            listService: r.copyWith(
              items: [...state.listService?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }

  Future<void> toggleServiceFavorite(int index) async {
    final oldServices = state.listService?.items ?? [];
    final oldService = oldServices[index];
    final newService = oldService.copyWith(
      isFavorite: !(oldService.isFavorite ?? false),
    );

    final newServices = List<ServiceModel>.from(oldServices)
      ..[index] = newService;
    emit(
      state.copyWith(
        listService: state.listService?.copyWith(items: newServices),
      ),
    );

    final response = await _serviceRepository.toggleServiceById(
      serviceId: state.listService!.items[index].id,
    );

    response.fold(
      (l) {},
      (r) {},
    );
  }
}
