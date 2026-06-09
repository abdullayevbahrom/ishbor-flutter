import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';

part 'realtime_state.freezed.dart';

@freezed
abstract class RealtimeState with _$RealtimeState {
  const factory RealtimeState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default({}) Map<String, dynamic> userStatuses,
  }) = _RealtimeState;
}
