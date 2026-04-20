import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/domain/repository/category_repository.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';

import '../../../data/models/category.dart';

part 'category_state.dart';

part 'category_cubit.freezed.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepository) : super(const CategoryState());
  final ScrollController scrollController = ScrollController();
  final CategoryRepository _categoryRepository;
  bool _isInitialized = false;

  int pageNumber = 1;

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

    if (maxScroll - currentScroll <= 20) {
      checkLoadMore();
    }
  }

  void checkLoadMore() {
    if (state.categories?.totalCount != state.categories?.items.length &&
        !state.isLoadingMore) {
      increasePageNumber();
      fetchMoreCategories();
    }
  }

  void increasePageNumber() {
    pageNumber += 1;
  }

  Future<void> fetchMoreCategories() async {
    emit(state.copyWith(isLoadingMore: true));

    final response = await _categoryRepository.fetchCategories(
      queryParams: QueryParams(size: 25, page: pageNumber),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            status: RequestStatus.error,
            errorText: l.message,
            isLoadingMore: false,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            status: RequestStatus.loaded,
            isLoadingMore: false,
            categories: CategoryListResponse(
              currentPageNumber: r.currentPageNumber,
              // usually the latest page
              numItemsPerPage: r.numItemsPerPage,
              items: [...state.categories?.items ?? [], ...r.items],
              totalCount: r.totalCount,
              paginatorOptions: r.paginatorOptions,
              customParameters: r.customParameters,
              route: r.route,
              params: r.params,
              pageRange: r.pageRange,
              pageLimit: r.pageLimit,
              template: r.template,
              sortableTemplate: r.sortableTemplate,
              filtrationTemplate: r.filtrationTemplate,
            ),
          ),
        );
        checkLoadMore();
      },
    );
  }

  Future<void> fetchCategories() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _categoryRepository.fetchCategories(
      queryParams: QueryParams(size: 25, page: pageNumber),
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, categories: r));
        checkLoadMore();
      },
    );
  }
}
