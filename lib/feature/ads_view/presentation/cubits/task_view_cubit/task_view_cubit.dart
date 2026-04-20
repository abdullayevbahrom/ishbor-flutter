import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/ads_view/data/models/task_request_params.dart';
import 'package:top_jobs/feature/ads_view/domain/repository/ads_view_repository.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/task_requests_repository.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../../tasks/data/models/task_model.dart';

part 'task_view_state.dart';

part 'task_view_cubit.freezed.dart';

class TaskViewCubit extends Cubit<TaskViewState> {
  TaskViewCubit(
    this._adsViewRepository,
    this._taskRepository,
    this._taskRequest,
  ) : super(const TaskViewState());

  final AdsViewRepository _adsViewRepository;
  final TaskRepository _taskRepository;
  final TaskRequestsRepository _taskRequest;
  int size = 10;
  int page = 1;

  fetchData(int taskId) {
    reset();
    fetchTaskById(taskId);
    fetchSimilarTasks();
    //fetchListRequestsTask();
  }

  void reset() {
    page = 1;
  }

  Future<void> fetchTaskById(int taskId) async {
    emit(state.copyWith(status: RequestStatus.loading, taskId: taskId));
    final response = await _adsViewRepository.fetchTaskById(taskId: taskId);

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, task: r));
        if (r.hasUserRequest ?? false) {
          fetchOwnTaskRequest();
        }
      },
    );
  }

  Future<void> toggleTask() async {
    final newTask = state.task?.copyWith(
      isFavorite: !(state.task?.isFavorite ?? false),
    );

    emit(state.copyWith(task: newTask));
    await _taskRepository.toggleTaskById(taskId: state.task!.id);
  }

  Future<void> fetchSimilarTasks() async {
    emit(state.copyWith(similarTasksSt: RequestStatus.loading));

    final response = await _taskRepository.fetchSimilarTasks(
      queryParams: CommonQueryParams(
        pageSize: size,
        pageNumber: page,
        id: state.taskId,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(similarTasksSt: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(similarTasksSt: RequestStatus.loaded, listTasks: r),
        );
      },
    );
  }

  Future<void> applyRequestTask(TaskRequestParams params) async {
    emit(state.copyWith(requestTasksSt: RequestStatus.loading));

    final response = await _taskRequest.applyRequestTask(params: params);

    response.fold(
      (l) {
        emit(state.copyWith(requestTasksSt: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(
            requestTasksSt: RequestStatus.loaded,
            task: state.task?.copyWith(hasUserRequest: true),
            myRequest: r
          ),
        );
        navigatorKey.currentContext?.pop();
        showSuccessToast(LocaleKeys.yourApplicationSenToEmployer.tr());
      },
    );
  }

  Future<void> fetchOwnTaskRequest() async {
    emit(state.copyWith(ownTaskRequestSt: RequestStatus.loading));

    final response = await _taskRequest.ownRequestsTask(taskId: state.taskId!);

    response.fold(
      (l) {
        emit(state.copyWith(ownTaskRequestSt: RequestStatus.error));
      },
      (r) {
        emit(
          state.copyWith(ownTaskRequestSt: RequestStatus.loaded, myRequest: r),
        );
      },
    );
  }

  //
  // Future<void> fetchListRequestsTask() async {
  //   emit(state.copyWith(applyRequestSt: RequestStatus.loading));
  //
  //   final response = await _taskViewDataSource.listRequestsTask(
  //     taskId: state.taskId!,
  //   );
  //
  //   response.fold(
  //     (l) {
  //       emit(state.copyWith(applyRequestSt: RequestStatus.error));
  //     },
  //     (r) {
  //       emit(
  //         state.copyWith(applyRequestSt: RequestStatus.loaded, listRequests: r),
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> choosePerformer(TaskRequest taskRequest) async {
  //   emit(
  //     state.copyWith(
  //       performerSt: RequestStatus.loading,
  //       selectedRequest: taskRequest,
  //     ),
  //   );
  //   final response = await _taskViewDataSource.choosePerformer(
  //     taskRequestId: taskRequest.id,
  //   );
  //
  //   response.fold(
  //     (l) {
  //       emit(
  //         state.copyWith(
  //           performerSt: RequestStatus.error,
  //           selectedRequest: null,
  //         ),
  //       );
  //     },
  //     (r) {
  //       final oldTask = state.task;
  //       final newTask = oldTask?.copyWith(performer: taskRequest.performer);
  //       emit(
  //         state.copyWith(
  //           performerSt: RequestStatus.loaded,
  //           task: newTask,
  //           selectedRequest: null,
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Future<void> cancelPerformer(TaskRequest taskRequest) async {
  //   emit(state.copyWith(cancelSt: RequestStatus.loading));
  //
  //   final response = await _taskViewDataSource.cancelTaskRequestByCustomer(
  //     taskRequestId: taskRequest.id,
  //   );
  //
  //   response.fold(
  //     (l) {
  //       showErrorToast(l.message);
  //       emit(state.copyWith(cancelSt: RequestStatus.error));
  //     },
  //     (r) {
  //       final oldTask = state.task;
  //       final newTask = oldTask?.copyWith(
  //         performer: null,
  //         clearPerformer: true,
  //       );
  //       print(newTask?.performer);
  //       emit(state.copyWith(cancelSt: RequestStatus.loaded, task: newTask));
  //       print(state.task?.performer);
  //       showSuccessToast(LocaleKeys.taskPerformerSuccessfullyRemoved.tr());
  //     },
  //   );
  // }
  //
  // Future<void> finishTask(TaskRequest taskRequest) async {
  //   emit(state.copyWith(finishSt: RequestStatus.loading));
  //
  //   final response = await _taskViewDataSource.finishTaskRequestByCustomer(
  //     taskRequestId: taskRequest.id,
  //   );
  //
  //   response.fold(
  //     (l) {
  //       showErrorToast(l.message);
  //       emit(state.copyWith(finishSt: RequestStatus.error));
  //     },
  //     (r) {
  //       final oldTask = state.task;
  //       final newTask = oldTask?.copyWith(status: "finished");
  //       showSuccessToast(LocaleKeys.taskSuccessfullyCompleted.tr());
  //       emit(state.copyWith(finishSt: RequestStatus.loaded, task: newTask));
  //     },
  //   );
  // }

  void checkLoadMoreData() {
    if (!state.isLoadingMore) {
      if (state.listTasks?.totalCount != state.listTasks?.items.length) {
        increasePage();
      }
    }
  }

  void increasePage() {
    page += 1;
  }

  Future<void> fetchMoreSimilarTasks() async {
    emit(state.copyWith(isLoadingMore: true));

    final response = await _taskRepository.fetchSimilarTasks(
      queryParams: CommonQueryParams(
        id: state.taskId,
        pageNumber: page,
        pageSize: size,
      ),
    );

    response.fold(
      (l) {
        emit(state.copyWith(isLoadingMore: false));
      },
      (r) {
        emit(
          state.copyWith(
            similarTasksSt: RequestStatus.loaded,
            isLoadingMore: false,
            listTasks: r.copyWith(
              items: [...state.listTasks?.items ?? [], ...r.items],
            ),
          ),
        );
      },
    );
  }
}
