import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/models/message.dart';

import '../../../../../models/vacancy.dart';
import '../../../../services/data/models/service.dart';
import '../../../../tasks/data/models/task_model.dart';

part 'notification_details_state.dart';

part 'notification_details_cubit.freezed.dart';

class NotificationDetailsCubit extends Cubit<NotificationDetailsState> {
  NotificationDetailsCubit(
    this._vacancyRepository,
    this._serviceRepository,
    this._taskRepository,
    this._messagesRepository,
  ) : super(const NotificationDetailsState());
  final VacancyRepository _vacancyRepository;
  final ServiceRepository _serviceRepository;
  final TaskRepository _taskRepository;
  final MessagesRepository _messagesRepository;

  Future<void> fetchDetails({required String type, required int id}) async {
    emit(state.copyWith(status: RequestStatus.loading));

    if (type == 'vacancy') {
      final response = await _vacancyRepository.fetchVacancyById(id: id);
      response.fold(
        (l) {
          emit(
            state.copyWith(status: RequestStatus.error, errorText: l.message),
          );
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, vacancy: r));
        },
      );
    }

    if (type == 'service') {
      final response = await _serviceRepository.fetchServiceById(id: id);
      response.fold(
        (l) {
          emit(
            state.copyWith(status: RequestStatus.error, errorText: l.message),
          );
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, service: r));
        },
      );
    }

    if (type == 'task') {
      final response = await _taskRepository.fetchTaskById(id: id);
      response.fold(
        (l) {
          emit(
            state.copyWith(status: RequestStatus.error, errorText: l.message),
          );
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, task: r));
        },
      );
    }

    if (type == "message") {
      final response = await _messagesRepository.fetchMessageById(
        messageId: id,
      );

      response.fold(
        (l) {
          emit(
            state.copyWith(status: RequestStatus.error, errorText: l.message),
          );
        },
        (r) {
          emit(state.copyWith(status: RequestStatus.loaded, message: r));
        },
      );
    }
  }
}
