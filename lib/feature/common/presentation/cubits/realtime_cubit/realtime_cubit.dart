import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:top_jobs/feature/common/domain/repository/realtime_repository.dart';
import 'realtime_state.dart';

class RealtimeCubit extends Cubit<RealtimeState> {
  RealtimeCubit(this._realtimeRepository) : super(const RealtimeState());
  final RealtimeRepository _realtimeRepository;
  Timer? _heartbeatTimer;

  void startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _realtimeRepository.heartbeat();
    });
    _realtimeRepository.heartbeat();
  }

  void stopHeartbeat() {
    _heartbeatTimer?.cancel();
  }

  Future<void> checkUserStatus(Object userId) async {
    final response = await _realtimeRepository.checkUserStatus(userId);
    response.fold((l) {}, (r) {
      final newUserStatuses = Map<String, dynamic>.from(state.userStatuses);
      newUserStatuses[userId.toString()] = r;
      emit(state.copyWith(userStatuses: newUserStatuses));
    });
  }

  @override
  Future<void> close() {
    _heartbeatTimer?.cancel();
    return super.close();
  }
}
