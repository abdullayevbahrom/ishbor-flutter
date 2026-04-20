import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';

import '../../../../../core/router/app_routes.dart';
import '../../../../main/presentation/cubit/main_cubit/main_cubit.dart';
import '../../../data/models/task_model.dart';

part 'task_state.dart';

part 'task_cubit.freezed.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._taskRepository) : super(const TaskState());
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final TaskRepository _taskRepository;
  bool _isInitialized = false;

  QueryParams _filters = QueryParams.empty();

  QueryParams get filters => _filters;
  int pageSize = 10;
  int pageNumber = 1;

  void resetFilters() {
    _filters = QueryParams.empty();
    reset();
  }

  void updateFilter(QueryParams queryParams) {
    _filters = queryParams;
    reset();
    fetchTasks();
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
      if (state.listTask?.items.length != state.listTask?.totalCount) {
        increasePageNumber();
        fetchMoreTasks();
      }
    }
  }

  void increasePageNumber() {
    pageNumber += 1;
  }

  Future<void> fetchTasks() async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _taskRepository.fetchTasks(
      queryParams: QueryParams(
        size: pageSize,
        page: pageNumber,
        title: controller.text.trim(),
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
        emit(state.copyWith(status: RequestStatus.loaded, listTask: r));
      },
    );
  }

  Future<void> fetchMoreTasks() async {
    emit(state.copyWith(isLoadingMore: true));
    final response = await _taskRepository.fetchTasks(
      queryParams: QueryParams(
        size: pageSize,
        page: pageNumber,
        title: controller.text.trim(),
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
            listTask: r.copyWith(
              items: [...state.listTask?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }

  Future<void> toggleTaskFavorite(int index) async {
    final oldTasks = state.listTask?.items ?? [];
    final oldTask = oldTasks[index];
    final newTask = oldTask.copyWith(
      isFavorite: !(oldTask.isFavorite ?? false),
    );
    final newTasks = List<TaskModel>.of(oldTasks)..[index] = newTask;

    emit(state.copyWith(listTask: state.listTask?.copyWith(items: newTasks)));

    final response = await _taskRepository.toggleTaskById(
      taskId: state.listTask!.items[index].id,
    );

    response.fold(
      (l) {},
      (r) {},
    );
  }
}
