part of 'feedback_cubit.dart';

@freezed
abstract class FeedbackState with _$FeedbackState {
  const factory FeedbackState({
    @Default(RequestStatus.initial) RequestStatus countSt,
    @Default(RequestStatus.initial) RequestStatus listSt,
    @Default(RequestStatus.initial) RequestStatus addReviewSt,
    @Default(null) PaginatedFeedbackResponse? listFeedBack,
    @Default(null) String? errorText,
    @Default(0) int countFeedback
  }) = _FeedbackState;
}
