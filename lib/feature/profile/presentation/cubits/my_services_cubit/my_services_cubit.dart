import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_service_repository.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';

import '../../../../services/data/models/service.dart';

part 'my_services_state.dart';

part 'my_services_cubit.freezed.dart';

class MyServicesCubit extends Cubit<MyServicesState> {
  MyServicesCubit(this._serviceRepository, this._myServiceRepository)
    : super(const MyServicesState());
  final ServiceRepository _serviceRepository;
  final MyServiceRepository _myServiceRepository;

  int size = 5;
  int pageMySv = 1;
  int pageMyFvSv = 1;

  void resetMySv() {
    pageMySv = 1;
  }

  void resetMyFvSv() {
    pageMyFvSv = 1;
  }

  void fetchMySvData() {
    resetMySv();
    fetchMyServices();
  }

  void fetchMyFvSvData() {
    resetMyFvSv();
    fetchMyServicesApplies();
  }

  Future<void> fetchMyServices() async {
    emit(state.copyWith(myServicesSt: RequestStatus.loading));

    final response = await _serviceRepository.fetchMyServices(
      queryParams: CommonQueryParams(pageNumber: pageMySv, pageSize: size),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            myServicesSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(state.copyWith(myServicesSt: RequestStatus.loaded, myServices: r));
      },
    );
  }

  Future<void> fetchMyServicesApplies() async {
    emit(state.copyWith(myServicesAppliesSt: RequestStatus.loading));

    final response = await _serviceRepository.fetchMyServiceApplies(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyFvSv),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            myServicesAppliesSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            myServicesAppliesSt: RequestStatus.loaded,
            myServicesApplies: r,
          ),
        );
      },
    );
  }

  Future<void> liftUpServiceById(int index) async {
    emit(state.copyWith(liftUpSt: RequestStatus.loading));
    final response = await _serviceRepository.liftUpServiceById(
      serviceId: state.myServices!.items[index].id,
    );
    response.fold(
      (l) {
        emit(state.copyWith(liftUpSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(liftUpSt: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.serviceLiftedUpSuccessfully.tr());
      },
    );
  }

  Future<void> deactivateServiceById(int serviceId, int index) async {
    emit(state.copyWith(deactivateSt: RequestStatus.loading));
    final response = await _myServiceRepository.changeStatusById(
      serviceId: serviceId,
      status: "deactivated",
    );
    response.fold(
      (l) {
        emit(state.copyWith(deactivateSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(deactivateSt: RequestStatus.loaded));

        final currentList = state.myServices?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedService = currentList[index].copyWith(
          status: "deactivated",
        );

        final updatedList = List<ServiceModel>.from(currentList)
          ..[index] = updatedService;

        emit(
          state.copyWith(
            myServicesSt: RequestStatus.loaded,
            myServices: state.myServices?.copyWith(items: updatedList),
          ),
        );

        showSuccessToast(LocaleKeys.serviceDeactivatedSuccessfully.tr());
      },
    );
  }

  Future<void> activateServiceById(int serviceId, int index) async {
    emit(state.copyWith(deactivateSt: RequestStatus.loading));
    final response = await _myServiceRepository.changeStatusById(
      serviceId: serviceId,
      status: "moderation",
    );
    response.fold(
          (l) {
        emit(state.copyWith(deactivateSt: RequestStatus.error));
        showErrorToast(l.message);
      },
          (r) {
        emit(state.copyWith(deactivateSt: RequestStatus.loaded));

        final currentList = state.myServices?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedService = currentList[index].copyWith(
          status: "moderation",
        );

        final updatedList = List<ServiceModel>.from(currentList)
          ..[index] = updatedService;

        emit(
          state.copyWith(
            myServicesSt: RequestStatus.loaded,
            myServices: state.myServices?.copyWith(items: updatedList),
          ),
        );

        showSuccessToast(LocaleKeys.serviceActivatedSuccessfully.tr());
      },
    );
  }


  Future<void> deleteServiceById(int index) async {
    emit(state.copyWith(deleteSt: RequestStatus.loading));
    final response = await _serviceRepository.deleteServiceById(
      serviceId: state.myServices!.items[index].id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(deleteSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(deleteSt: RequestStatus.loaded));

        final currentList = state.myServices?.items ?? [];

        if (index < 0 || index >= currentList.length) return;

        final updatedList = List<ServiceModel>.from(currentList)
          ..removeAt(index);
        emit(
          state.copyWith(
            myServices: state.myServices?.copyWith(
              items: updatedList,
              totalCount: state.myServices?.totalCount ?? 0 - 1,
            ),

            myServicesSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.serviceDeletedSuccessfully.tr());
      },
    );
  }

  Future<void> toggleService(int index) async {
    final oldServices = state.myServices?.items ?? [];
    final oldService = oldServices[index];
    final newService = oldService.copyWith(
      isFavorite: !(oldService.isFavorite ?? false),
    );

    final newTasks = List<ServiceModel>.from(oldServices)..[index] = newService;
    emit(
      state.copyWith(myServices: state.myServices?.copyWith(items: newTasks)),
    );

    final response = await _serviceRepository.toggleServiceById(
      serviceId: oldService.id,
    );
    response.fold(
      (l) {
        debugPrint("Vacancy toggle Failure");
      },
      (r) {
        debugPrint("Vacancy toggle SUCCESS");
      },
    );
  }

  void checkLoadMoreMySv() {
    if (state.myServices?.totalCount != state.myServices?.items.length &&
        !state.isLadingMore1) {
      increase();
      fetchMoreMySv();
    }
  }

  void increase() {
    pageMySv += 1;
  }

  Future<void> fetchMoreMySv() async {
    emit(state.copyWith(isLadingMore1: true));

    final response = await _serviceRepository.fetchMyServices(
      queryParams: CommonQueryParams(pageNumber: pageMySv, pageSize: size),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            isLadingMore1: false,
            myServicesSt: RequestStatus.error,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLadingMore1: false,
            myServicesSt: RequestStatus.loaded,
            myServices: r.copyWith(
              items: [...state.myServices?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }
}
