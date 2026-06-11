import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/performers_view/domain/repository/task_requests_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../data/models/paginated_task_requests.dart';

part 'task_requests_state.dart';

part 'task_requests_cubit.freezed.dart';

class TaskRequestsCubit extends Cubit<TaskRequestsState> {
  TaskRequestsCubit(this._requestsRepository)
    : super(const TaskRequestsState());
  final TaskRequestsRepository _requestsRepository;

  int page = 1;
  int size = 10;

  void reset() {
    page = 1;
  }

  Future<void> fetchRequestsByTask(TaskModel taskModel) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=list_by_task id=${taskModel.id}',
    );
    emit(state.copyWith(status: RequestStatus.loading, task: taskModel));

    final response = await _requestsRepository.listRequestsByTask(
      taskId: taskModel.id,
      page: page,
      size: size,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listTaskRequest: r));
      },
    );
  }

  Future<void> acceptRequest(TaskRequest taskRequest) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=accept id=${taskRequest.id}',
    );
    emit(
      state.copyWith(
        choosePerformerSt: RequestStatus.loading,
        taskRequest: taskRequest,
      ),
    );

    final response = await _requestsRepository.acceptRequest(
      requestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            choosePerformerSt: RequestStatus.error,
            taskRequest: null,
          ),
        );
        showErrorToast(l.message);
      },
      (r) {
        emit(
          state.copyWith(
            choosePerformerSt: RequestStatus.loaded,
            task: state.task?.copyWith(performer: taskRequest.performer),
            taskRequest: null,
          ),
        );
        showSuccessToast(LocaleKeys.performerHasBeenChosen.tr());
      },
    );
  }

  Future<void> cancelByCustomer(TaskRequest taskRequest) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=cancel_by_customer id=${taskRequest.id}',
    );
    emit(state.copyWith(cancelPerformerSt: RequestStatus.loading));

    final response = await _requestsRepository.cancelRequestByCustomer(
      requestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(cancelPerformerSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(
          state.copyWith(
            cancelPerformerSt: RequestStatus.loaded,
            task: state.task?.copyWith(performer: null, clearPerformer: true),
          ),
        );
        showSuccessToast(LocaleKeys.taskPerformerSuccessfullyRemoved.tr());
      },
    );
  }

  Future<void> cancelByPerformer(TaskRequest taskRequest) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=cancel_by_performer id=${taskRequest.id}',
    );
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _requestsRepository.cancelRequestByPerformer(
      requestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.applicationCancelledSuccessfully.tr());
      },
    );
  }

  Future<void> finishTask(TaskRequest taskRequest) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=finish id=${taskRequest.id}',
    );
    emit(state.copyWith(finishTaskSt: RequestStatus.loading));

    final response = await _requestsRepository.finishRequestByCustomer(
      requestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(finishTaskSt: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(
          state.copyWith(
            finishTaskSt: RequestStatus.loaded,
            task: state.task?.copyWith(status: "finished"),
          ),
        );
        showSuccessToast(LocaleKeys.taskSuccessfullyCompleted.tr());
      },
    );
  }

  Future<void> changeStatus(TaskRequest taskRequest, String status) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=change_status id=${taskRequest.id} status=$status',
    );
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _requestsRepository.changeStatus(
      requestId: taskRequest.id,
      status: status,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.statusChangedSuccessfully.tr());
      },
    );
  }

  Future<void> deleteRequest(TaskRequest taskRequest) async {
    debugPrint(
      '[DEBUG][TaskRequestsCubit] action=delete id=${taskRequest.id}',
    );
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _requestsRepository.deleteRequest(
      requestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        showSuccessToast(LocaleKeys.applicationDeletedSuccessfully.tr());
      },
    );
  }
}
