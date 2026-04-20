import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/feature/ads_view/data/models/ads_contact_model.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_contact_repository.dart';

part 'ads_contact_state.dart';

part 'ads_contact_cubit.freezed.dart';

class AdsContactCubit extends Cubit<AdsContactState> {
  AdsContactCubit(this._adsContactRepository, this._storageService)
    : super(const AdsContactState());
  final AdsContactRepository _adsContactRepository;
  final StorageService _storageService;

  Future<void> fetchCountOfPhoneReq() async {
    final countOfReq = await _storageService.getCountOfPhoneReq();
    emit(state.copyWith(countOfPhoneReq: countOfReq));
  }

  Future<void> fetchVacancyContact(int vacancyId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    await _storageService.putCountOfPhoneReq();
    final response = await _adsContactRepository.fetchVacancyContact(
      vacancyId: vacancyId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            contact: r,
            countOfPhoneReq: state.countOfPhoneReq + 1,
          ),
        );
      },
    );
  }

  Future<void> fetchServiceContact(int serviceId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _adsContactRepository.fetchServiceContact(
      serviceId: serviceId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, contact: r));
      },
    );
  }

  Future<void> fetchTaskContact(int taskId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _adsContactRepository.fetchTaskContact(
      taskId: taskId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, contact: r));
      },
    );
  }
}
