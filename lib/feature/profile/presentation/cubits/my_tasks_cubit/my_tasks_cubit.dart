import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/profile/domain/repository/my_task_repository.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../../tasks/data/models/task_model.dart';
import '../../../data/model/paginatated_task_requests.dart';

part 'my_tasks_state.dart';

part 'my_tasks_cubit.freezed.dart';

class MyTasksCubit extends Cubit<MyTasksState> {
  MyTasksCubit(this._taskRepository, this._myTasksRepository)
    : super(const MyTasksState());
  final TaskRepository _taskRepository;
  final MyTasksRepository _myTasksRepository;
  int size = 5;
  int pageMyTs = 1;
  int pageMyFcTs = 1;

  void resetMyTs() {
    pageMyTs = 1;
  }

  void resetMyFcTs() {
    pageMyFcTs = 1;
  }

  void fetchMyTsData() {
    resetMyTs();
    fetchMyTasks();
  }

  void fetchMyFcTs() {
    resetMyFcTs();
    fetchMyTaskApplies();
  }

  Future<void> fetchMyTasks() async {
    emit(state.copyWith(myTaskSt: RequestStatus.loading));

    final response = await _taskRepository.fetchMyTasks(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyTs),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(myTaskSt: RequestStatus.error, errorText: l.message),
        );
      },
      (r) {
        emit(state.copyWith(myTaskSt: RequestStatus.loaded, myTasks: r));
      },
    );
  }

  Future<void> fetchMyTaskApplies() async {
    emit(state.copyWith(myTaskAppliesSt: RequestStatus.loading));
    final response = await _taskRepository.fetchMyTaskApplies(
      queryParams: CommonQueryParams(pageNumber: pageMyFcTs, pageSize: size),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            myTaskAppliesSt: RequestStatus.error,
            errorText: l.message,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            myTaskAppliesSt: RequestStatus.loaded,
            myTaskApplies: r,
          ),
        );
      },
    );
  }

  Future<void> liftUpTaskById(int taskId) async {
    emit(state.copyWith(liftUpTaskSt: RequestStatus.loading));
    final response = await _taskRepository.liftUpTaskById(taskId: taskId);
    response.fold(
      (l) {
        emit(state.copyWith(liftUpTaskSt: RequestStatus.error));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(liftUpTaskSt: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.taskLiftedUpSuccessfully.tr());
        fetchMyTasks();
      },
    );
  }

  Future<void> deactivateTaskById(int taskId, int index) async {
    emit(state.copyWith(deactivateTaskSt: RequestStatus.loading));
    final response = await _myTasksRepository.changeStatusById(
      taskId: taskId,
      status: "deactivated",
    );

    response.fold(
      (l) {
        emit(state.copyWith(deactivateTaskSt: RequestStatus.error));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(deactivateTaskSt: RequestStatus.loaded));
        final currentList = state.myTasks?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedTask = currentList[index].copyWith(status: "deactivated");

        final updatedList = List<TaskModel>.from(currentList)
          ..[index] = updatedTask;

        emit(
          state.copyWith(
            myTasks: state.myTasks?.copyWith(items: updatedList),
            myTaskSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.taskDeactivatedSuccessfully.tr());
      },
    );
  }

  Future<void> activateTaskById(int taskId, int index) async {
    emit(state.copyWith(deactivateTaskSt: RequestStatus.loading));
    final response = await _myTasksRepository.changeStatusById(
      taskId: taskId,
      status: "moderation",
    );

    response.fold(
      (l) {
        emit(state.copyWith(deactivateTaskSt: RequestStatus.error));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(deactivateTaskSt: RequestStatus.loaded));
        final currentList = state.myTasks?.items ?? [];
        if (index < 0 || index >= currentList.length) return;
        final updatedTask = currentList[index].copyWith(status: "moderation");

        final updatedList = List<TaskModel>.from(currentList)
          ..[index] = updatedTask;

        emit(
          state.copyWith(
            myTasks: state.myTasks?.copyWith(items: updatedList),
            myTaskSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.taskActivatedSuccessfully.tr());
      },
    );
  }

  Future<void> deleteTaskById(int taskId, int index) async {
    emit(state.copyWith(deleteTaskSt: RequestStatus.loading));

    final response = await _taskRepository.deleteTaskById(taskId: taskId);

    response.fold(
      (l) {
        emit(state.copyWith(deleteTaskSt: RequestStatus.error));
        showErrorToast(l.message ?? LocaleKeys.unExpectedError.tr());
      },
      (r) {
        emit(state.copyWith(deleteTaskSt: RequestStatus.loaded));

        final currentList = state.myTasks?.items ?? [];

        if (index < 0 || index >= currentList.length) return;

        final updatedList = List<TaskModel>.from(currentList)..removeAt(index);
        emit(
          state.copyWith(
            myTasks: state.myTasks?.copyWith(
              items: updatedList,
              totalCount: state.myTasks?.totalCount ?? 0 - 1,
            ),

            myTaskSt: RequestStatus.loaded,
          ),
        );
        showSuccessToast(LocaleKeys.taskDeletedSuccessfully.tr());
      },
    );
  }

  Future<void> toggleMyTask(int index) async {
    final oldTasks = state.myTasks?.items ?? [];
    final oldTask = oldTasks[index];
    final newTask = oldTask.copyWith(
      isFavorite: !(oldTask.isFavorite ?? false),
    );

    final newTasks = List<TaskModel>.from(oldTasks)..[index] = newTask;
    emit(state.copyWith(myTasks: state.myTasks?.copyWith(items: newTasks)));

    final response = await _taskRepository.toggleTaskById(taskId: oldTask.id);
    response.fold(
      (l) {
        debugPrint("Vacancy toggle Failure");
      },
      (r) {
        debugPrint("Vacancy toggle SUCCESS");
      },
    );
  }

  Future<void> toggleMyAppLiedTask(int index) async {
    final oldTaskRequests = state.myTaskApplies?.items;
    final oldTaskRequest = oldTaskRequests?[index];
    final newTask = oldTaskRequest?.task?.copyWith(
      isFavorite: !(oldTaskRequest.task?.isFavorite ?? false),
    );

    final newTaskRequest = oldTaskRequest?.copyWith(task: newTask);

    final newTasks = List<TaskRequest>.from(state.myTaskApplies?.items ?? [])
      ..[index] = newTaskRequest!;

    emit(
      state.copyWith(
        myTaskApplies: state.myTaskApplies?.copyWith(items: newTasks),
      ),
    );

    final response = await _taskRepository.toggleTaskById(
      taskId: oldTaskRequest!.task!.id,
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

  checkLoadMoreMyTs() {
    if (state.myTasks?.items.length != state.myTasks?.totalCount &&
        !state.isLoadingMore1) {
      increasePageMyTs();
      fetchMoreMyTs();
    }
  }

  increasePageMyTs() {
    pageMyTs += 1;
  }

  Future<void> fetchMoreMyTs() async {
    emit(state.copyWith(isLoadingMore1: true));

    final response = await _taskRepository.fetchMyTasks(
      queryParams: CommonQueryParams(pageSize: size, pageNumber: pageMyTs),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            myTaskAppliesSt: RequestStatus.error,
            isLoadingMore1: false,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            myTaskAppliesSt: RequestStatus.loaded,
            isLoadingMore1: false,
            myTasks: r.copyWith(
              items: [...state.myTasks?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }

  void checkLoadMoreMyFcTs() {
    if (state.myTaskApplies?.totalCount != state.myTaskApplies?.items.length &&
        !state.isLoadingMore2) {
      increaseMyFcTs();
      fetchMoreMyFcTs();
    }
  }

  void increaseMyFcTs() {
    pageMyFcTs += 1;
  }

  Future<void> fetchMoreMyFcTs() async {
    emit(state.copyWith(isLoadingMore2: true));
    final response = await _taskRepository.fetchMyTaskApplies(
      queryParams: CommonQueryParams(pageNumber: pageMyFcTs, pageSize: size),
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            isLoadingMore2: false,
            myTaskAppliesSt: RequestStatus.error,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            isLoadingMore2: false,
            myTaskAppliesSt: RequestStatus.loaded,
            myTaskApplies: r.copyWith(
              items: [...state.myTaskApplies?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }
}
