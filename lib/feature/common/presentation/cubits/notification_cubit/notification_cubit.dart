import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/feature/common/domain/repository/notification_repository.dart';

import '../../../data/models/notifications.dart';

part 'notification_state.dart';

part 'notification_cubit.freezed.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._notificationsRepository)
    : super(const NotificationState());
  final NotificationsRepository _notificationsRepository;

  Future<void> fetchNotifications() async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _notificationsRepository.fetchNotifications();
    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded, listNotification: r));
        checkNewNotification();
      },
    );
  }

  Future<void> makeNotificationRead(int index) async {
    final response = await _notificationsRepository.makeNotificationRead(
      notificationId: state.listNotification!.items[index].id,
    );
    response.fold((l) {}, (r) {
      final List<AppNotification> oldItems = List.from(
        state.listNotification?.items ?? [],
      );
      oldItems[index] = oldItems[index].copyWith(read: true);

      emit(
        state.copyWith(
          listNotification: state.listNotification?.copyWith(items: oldItems),
        ),
      );
    });
    checkNewNotification();
  }

  void checkNewNotification() {
    List<bool> notificationsStatus = [];
    for (AppNotification? element in (state.listNotification?.items ?? [])) {
      notificationsStatus.add(element?.read ?? false);
    }
    if (notificationsStatus.contains(false)) {
      emit(state.copyWith(hasNewNotification: true));
    } else {
      emit(state.copyWith(hasNewNotification: false));
    }
  }
}
