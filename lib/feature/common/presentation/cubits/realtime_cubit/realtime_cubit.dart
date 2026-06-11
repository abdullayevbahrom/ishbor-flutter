import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/feature/common/domain/repository/realtime_repository.dart';
import 'realtime_state.dart';

class RealtimeCubit extends Cubit<RealtimeState> {
  RealtimeCubit(this._realtimeRepository) : super(const RealtimeState());
  final RealtimeRepository _realtimeRepository;
  Timer? _heartbeatTimer;

  void startHeartbeat() {
    debugPrint('[DEBUG][realtime] start heartbeat interval=1m');
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      debugPrint('[DEBUG][realtime] heartbeat tick=${timer.tick}');
      _realtimeRepository.heartbeat().then(
        (response) {
          response.fold(
            (failure) {
              debugPrint(
                '[WARN][realtime] heartbeat sync failed: ${failure.message}',
              );
            },
            (_) {
              debugPrint('[DEBUG][realtime] heartbeat synced');
            },
          );
        },
      );
    });
    _realtimeRepository.heartbeat().then(
      (response) {
        response.fold(
          (failure) {
            debugPrint(
              '[WARN][realtime] heartbeat sync failed: ${failure.message}',
            );
          },
          (_) {
            debugPrint('[DEBUG][realtime] heartbeat synced');
          },
        );
      },
    );
  }

  void stopHeartbeat() {
    debugPrint('[DEBUG][realtime] stop heartbeat');
    _heartbeatTimer?.cancel();
  }

  Future<void> checkUserStatus(Object userId) async {
    debugPrint('[DEBUG][realtime] check user status userId=${userId.toString()}');
    final response = await _realtimeRepository.checkUserStatus(userId);
    response.fold(
      (failure) {
        debugPrint(
          '[WARN][realtime] status sync failed userId=${userId.toString()}: ${failure.message}',
        );
      },
      (status) {
        debugPrint(
          '[DEBUG][realtime] status synced userId=${userId.toString()} payload=$status',
        );
        final newUserStatuses = Map<String, dynamic>.from(state.userStatuses);
        newUserStatuses[userId.toString()] = status;
        emit(state.copyWith(userStatuses: newUserStatuses));
      },
    );
  }

  @override
  Future<void> close() {
    _heartbeatTimer?.cancel();
    return super.close();
  }
}
