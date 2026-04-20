import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/common/data/models/pagination_model.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';
import 'package:top_jobs/feature/vacancies/data/models/new_vacancy_model.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';

import '../../../../../models/vacancy.dart';

part 'vacancy_state.dart';

part 'vacancy_cubit.freezed.dart';

class VacancyCubit extends Cubit<VacancyState> {
  VacancyCubit(this._vacancyRepository) : super(const VacancyState());
  final VacancyRepository _vacancyRepository;
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  int pageNumber = 1;
  int pageSize = 10;
  QueryParams _filters = QueryParams.empty();
  bool _isInitialized = false;

  QueryParams get filters => _filters;

  void resetFilter() {
    reset();
    _filters = QueryParams.empty();
  }

  void updateFilter(QueryParams queryParams) {
    _filters = queryParams;
    reset();
    fetchVacancies();
  }

  void reset() {
    pageNumber = 1;
  }

  void initialize() {
    if (_isInitialized) {
      return;
    }
    _isInitialized = true;
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (navigatorKey.currentContext?.read<MainCubit>().state.isOpen ?? false) {
      navigatorKey.currentContext?.read<MainCubit>().updateOpen(false);
    }

    if (navigatorKey.currentContext
            ?.read<MainCubit>()
            .state
            .isNotificationMenuOpen ??
        false) {
      navigatorKey.currentContext?.read<MainCubit>().updateNtfMenu(false);
    }

    if (maxScroll - currentScroll <= 20 && !state.isLoadingMore) {
      checkMoreData();
    }
  }

  void checkMoreData() {
    if (state.newVacancies?.items?.length !=
        (state.newVacancies?.totalCount ?? 0)) {
      increasePageNumber();
      fetchMoreVacancies();
    }
  }

  void increasePageNumber() {
    pageNumber += 1;
  }

  Future<void> fetchVacancies() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _vacancyRepository.fetchNewVacancies(
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
      (failure) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (response) {
        emit(
          state.copyWith(status: RequestStatus.loaded, newVacancies: response),
        );
      },
    );
  }

  Future<void> fetchMoreVacancies() async {
    emit(state.copyWith(isLoadingMore: true));
    final response = await _vacancyRepository.fetchNewVacancies(
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
            isLoadingMore: false,
            status: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            isLoadingMore: false,
            newVacancies: r.copyWith(
              items: [...state.newVacancies?.items ?? [], ...r.items ?? []],
            ),
          ),
        );
      },
    );
  }

  Future<void> fetchSimilarVacancies(int id) async {
    emit(state.copyWith(similarVacSt: RequestStatus.loading));

    final response = await _vacancyRepository.fetchSimilarVacancies(
      queryParams: CommonQueryParams(id: id),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            similarVacSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            similarVacSt: RequestStatus.loaded,
            listSimilarVacancy: r,
          ),
        );
      },
    );
  }

  Future<void> updateFavorite(int index) async {
    final oldVacancies = state.newVacancies?.items ?? [];
    final oldVacancy = oldVacancies[index];
    final newVacancy = oldVacancy.copyWith(
      isFavorite: !(oldVacancy.isFavorite ?? false),
    );
    final updatedVacancies = List<NewVacancyModel>.from(oldVacancies)
      ..[index] = newVacancy;
    emit(
      state.copyWith(
        newVacancies: state.newVacancies?.copyWith(items: updatedVacancies),
      ),
    );

    final response = await _vacancyRepository.toggleFavorite(
      vacancyId: state.newVacancies!.items![index].id!,
    );

    response.fold(
      (l) {
        debugPrint("Toggle vacancy Failure:${l.message}");
      },
      (r) {
        debugPrint("Toggle vacancy SUCCESS");
      },
    );
  }
}
