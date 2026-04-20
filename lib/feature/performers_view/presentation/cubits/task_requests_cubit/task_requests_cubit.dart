import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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

  Future<void> requestApplyTask(TaskModel taskModel) async {
    emit(state.copyWith(status: RequestStatus.loading, task: taskModel));

    final response = await _requestsRepository.listRequestsTask(
      taskId: taskModel.id,
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

  Future<void> choosePerformer(TaskRequest taskRequest) async {
    emit(
      state.copyWith(
        choosePerformerSt: RequestStatus.loading,
        taskRequest: taskRequest,
      ),
    );

    final response = await _requestsRepository.choosePerformer(
      taskRequestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(
          state.copyWith(
            choosePerformerSt: RequestStatus.error,
            taskRequest: null,
          ),
        );
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

  Future<void> cancelPerformer(TaskRequest taskRequest) async {
    emit(state.copyWith(cancelPerformerSt: RequestStatus.loading));

    final response = await _requestsRepository.cancelTaskRequestByCustomer(
      taskRequestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(cancelPerformerSt: RequestStatus.error));
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

  Future<void> finishTask(TaskRequest taskRequest) async {
    emit(state.copyWith(finishTaskSt: RequestStatus.loading));

    final response = await _requestsRepository.finishTaskRequestByCustomer(
      taskRequestId: taskRequest.id,
    );

    response.fold(
      (l) {
        emit(state.copyWith(finishTaskSt: RequestStatus.error));
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
}
