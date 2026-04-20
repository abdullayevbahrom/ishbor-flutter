import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_view_repository.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';

import '../../../../../models/vacancy.dart';

part 'vacancy_view_state.dart';

part 'vacancy_view_cubit.freezed.dart';

class VacancyViewCubit extends Cubit<VacancyViewState> {
  VacancyViewCubit(this._adsViewRepository, this._vacancyRepository)
    : super(const VacancyViewState());

  final AdsViewRepository _adsViewRepository;
  final VacancyRepository _vacancyRepository;

  int pageNumber = 1;
  int pageSize = 10;

  void fetchData(int vacancyId) {
    reset();
    fetchVacancyById(vacancyId);
  }

  void reset() {
    pageNumber = 1;
  }

  Future<void> fetchVacancyById(int vacancyId) async {
    emit(state.copyWith(status: RequestStatus.loading, vacancyId: vacancyId));
    final response = await _adsViewRepository.fetchVacancyById(
      vacancyId: vacancyId,
    );
    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, vacancy: r));
        fetchSimilarVacancies();
      },
    );
  }

  Future<void> toggleFavorite() async {
    final newVacancy = state.vacancy?.copyWith(
      isFavorite: !(state.vacancy?.isFavorite ?? false),
    );
    emit(state.copyWith(vacancy: newVacancy));
    await _vacancyRepository.toggleFavorite(vacancyId: state.vacancy!.id);
  }

  Future<void> fetchSimilarVacancies() async {
    emit(state.copyWith(similarVacanciesSt: RequestStatus.loading));

    final response = await _vacancyRepository.fetchSimilarVacancies(
      queryParams: CommonQueryParams(
        id: state.vacancyId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(similarVacanciesSt: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(
            similarVacanciesSt: RequestStatus.loaded,
            listSimilarVacancy: r,
          ),
        );
      },
    );
  }

  void checkLoadMoreData() {
    if (!state.isLoadingMore) {
      if (state.listSimilarVacancy?.totalCount !=
          state.listSimilarVacancy?.items.length) {
        increasePage();
        fetchMoreSimilarVacancies();
      }
    }
  }

  void increasePage() {
    pageNumber += 1;
  }

  Future<void> fetchMoreSimilarVacancies() async {
    emit(state.copyWith(isLoadingMore: true));

    final response = await _vacancyRepository.fetchSimilarVacancies(
      queryParams: CommonQueryParams(
        id: state.vacancyId,
        pageSize: pageSize,
        pageNumber: pageNumber,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (r) {
        final oldVacancies = state.listSimilarVacancy?.items ?? [];
        final newVacancies = [...oldVacancies, ...r.items];

        emit(
          state.copyWith(
            similarVacanciesSt: RequestStatus.loaded,
            isLoadingMore: false,
            listSimilarVacancy: r.copyWith(items: newVacancies),
          ),
        );
      },
    );
  }
}
