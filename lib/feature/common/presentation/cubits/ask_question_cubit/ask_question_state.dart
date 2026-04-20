part of 'ask_question_cubit.dart';

@freezed
abstract class AskQuestionState with _$AskQuestionState {
  const factory AskQuestionState({
    @Default(RequestStatus.initial) RequestStatus status,
    @Default(RequestStatus.initial) RequestStatus reportSt,
    @Default(null) String? errorText,
  }) = _AskQuestionState;
}
