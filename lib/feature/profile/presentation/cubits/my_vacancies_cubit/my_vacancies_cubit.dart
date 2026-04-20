import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_vacancies_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';

import '../../../../../models/vacancy.dart';

part 'my_vacancies_state.dart';

part 'my_vacancies_cubit.freezed.dart';

class MyVacanciesCubit extends Cubit<MyVacanciesState> {
  MyVacanciesCubit(this._vacancyRepository, this._myVacanciesRepository)
    : super(const MyVacanciesState());
  final VacancyRepository _vacancyRepository;
  final MyVacanciesRepository _myVacanciesRepository;

  int size = 20;
  int pageMyVc = 1;
  int pageMyFcVc = 1;

  void fetchMyVcData() {
    resetMyVc();
    fetchMyVacancies();
  }

  void fetchMyFcVcData() {
    resetMyFcVc();
    fetchMyAppliedVacancies();
  }

  void resetMyVc() {
    pageMyVc = 1;
  }

  void resetMyFcVc() {
    pageMyFcVc = 1;
  }

  Future<void> fetchMyVacancies() async {
    emit(state.copyWith(vacanciesSt: RequestStatus.loading));

    final response = await _vacancyRepository.fetchUserVacancies(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyVc),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            vacanciesSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(state.copyWith(vacanciesSt: RequestStatus.loaded, myVacancies: r));
      },
    );
  }

  Future<void> fetchMyAppliedVacancies() async {
    emit(state.copyWith(appliedVacanciesSt: RequestStatus.loading));
    final response = await _vacancyRepository.fetchAppliedVacancies(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyFcVc),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            appliedVacanciesSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            appliedVacanciesSt: RequestStatus.loaded,
            myAppliedVacancies: r,
          ),
        );
      },
    );
  }

  Future<void> liftUpVacancyById(int vacancyId) async {
    emit(state.copyWith(liftUpSt: RequestStatus.loading));
    final response = await _vacancyRepository.liftUpVacancyById(
      vacancyId: vacancyId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(liftUpSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(liftUpSt: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.vacancyLiftedUpSuccessfully.tr());
      },
    );
  }

  Future<void> deactivateVacancyById(int vacancyId, int index) async {
    emit(state.copyWith(deactivateSt: RequestStatus.loading));
    final response = await _myVacanciesRepository.changeVacancyStatus(
      status: "deactivated",
      vacancyId: vacancyId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(deactivateSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(deactivateSt: RequestStatus.loaded));
        final currentList = state.myVacancies?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedVacancy = currentList[index].copyWith(
          status: "deactivated",
        );

        final updatedList = List<Vacancy>.from(currentList)
          ..[index] = updatedVacancy;

        emit(
          state.copyWith(
            myVacancies: state.myVacancies?.copyWith(items: updatedList),
            vacanciesSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.vacancyDeactivatedSuccessfully.tr());
      },
    );
  }

  Future<void> activateVacancyById(int vacancyId, int index) async {
    emit(state.copyWith(deactivateSt: RequestStatus.loading));
    final response = await _myVacanciesRepository.changeVacancyStatus(
      status: "moderation",
      vacancyId: vacancyId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(deactivateSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(deactivateSt: RequestStatus.loaded));
        final currentList = state.myVacancies?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedVacancy = currentList[index].copyWith(
          status: "moderation",
        );

        final updatedList = List<Vacancy>.from(currentList)
          ..[index] = updatedVacancy;

        emit(
          state.copyWith(
            myVacancies: state.myVacancies?.copyWith(items: updatedList),
            vacanciesSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.vacancyActivatedSuccessfully.tr());
      },
    );
  }

  Future<void> deleteVacancyById(int vacancyId, int index) async {
    emit(state.copyWith(deleteSt: RequestStatus.loading));

    final response = await _vacancyRepository.deleteVacancyById(
      vacancyId: vacancyId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(deleteSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(deleteSt: RequestStatus.loaded));

        final currentList = state.myVacancies?.items ?? [];

        if (index < 0 || index >= currentList.length) return;

        final updatedList = List<Vacancy>.from(currentList)..removeAt(index);
        emit(
          state.copyWith(
            myVacancies: state.myVacancies?.copyWith(
              items: updatedList,
              totalCount: state.myVacancies?.totalCount ?? 0 - 1,
            ),

            vacanciesSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.vacancyDeletedSuccessfully.tr());
      },
    );
  }

  Future<void> toggleVacancy(int index) async {
    final oldVacancies = state.myVacancies?.items ?? [];
    final oldVacancy = state.myVacancies?.items[index];
    final newVacancy = oldVacancy?.copyWith(
      isFavorite: !(oldVacancy.isFavorite ?? false),
    );
    final newVacancies = List<Vacancy>.from(oldVacancies)
      ..[index] = newVacancy!;

    emit(
      state.copyWith(
        myVacancies: state.myVacancies?.copyWith(items: newVacancies),
      ),
    );

    final response = await _vacancyRepository.toggleFavorite(
      vacancyId: oldVacancy!.id,
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

  void checkLoadMoreMyVacancies() {
    if (state.myVacancies?.totalCount != state.myVacancies?.items.length &&
        !state.isLoadingMore1) {
      increaseMyVcPage();
      fetchMoreMyVc();
    }
  }

  increaseMyVcPage() {
    pageMyVc += 1;
  }

  Future<void> fetchMoreMyVc() async {
    emit(state.copyWith(isLoadingMore1: true));

    final response = await _vacancyRepository.fetchUserVacancies(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyVc),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            isLoadingMore1: false,
            vacanciesSt: RequestStatus.error,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            vacanciesSt: RequestStatus.loaded,
            isLoadingMore1: false,
            myVacancies: r.copyWith(
              items: [...state.myVacancies?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }
}
