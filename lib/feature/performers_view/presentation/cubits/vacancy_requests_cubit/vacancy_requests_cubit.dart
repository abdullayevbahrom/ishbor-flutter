import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/performers_view/data/models/paginated_vacancy_requests.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/vacancy_requests_repository.dart';
import 'package:top_jobs/models/vacancy.dart';
import 'package:top_jobs/models/vacancy_request.dart';

part 'vacancy_requests_state.dart';
part 'vacancy_requests_cubit.freezed.dart';

class VacancyRequestsCubit extends Cubit<VacancyRequestsState> {
  VacancyRequestsCubit(this._requestsRepository)
    : super(const VacancyRequestsState());
  final VacancyRequestsRepository _requestsRepository;

  int page = 1;
  int size = 10;

  void reset() {
    page = 1;
  }

  Future<void> fetchRequestsByVacancy(Vacancy vacancy) async {
    debugPrint(
      '[DEBUG][VacancyRequestsCubit] action=list_by_vacancy id=${vacancy.id}',
    );
    emit(state.copyWith(status: RequestStatus.loading, vacancy: vacancy));

    final response = await _requestsRepository.listRequestsByVacancy(
      vacancyId: vacancy.id,
      page: page,
      size: size,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(
          state.copyWith(status: RequestStatus.loaded, listVacancyRequest: r),
        );
      },
    );
  }

  Future<void> changeStatus(
    VacancyRequest vacancyRequest,
    String status,
  ) async {
    debugPrint(
      '[DEBUG][VacancyRequestsCubit] action=change_status id=${vacancyRequest.id} status=$status',
    );
    emit(
      state.copyWith(
        changeStatusSt: RequestStatus.loading,
        vacancyRequest: vacancyRequest,
      ),
    );

    final response = await _requestsRepository.changeStatus(
      requestId: vacancyRequest.id,
      status: status,
    );

    response.fold(
      (l) {
        emit(state.copyWith(changeStatusSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(
          state.copyWith(
            changeStatusSt: RequestStatus.loaded,
            vacancyRequest: r,
          ),
        );
        showSuccessToast('Status changed successfully');
      },
    );
  }

  Future<void> deleteRequest(VacancyRequest vacancyRequest) async {
    debugPrint(
      '[DEBUG][VacancyRequestsCubit] action=delete id=${vacancyRequest.id}',
    );
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _requestsRepository.deleteRequest(
      requestId: vacancyRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        showSuccessToast('Application deleted successfully');
      },
    );
  }
}
