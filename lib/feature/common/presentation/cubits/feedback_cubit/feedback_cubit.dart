import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/feature/common/domain/repository/feedback_repository.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../../core/helpers/enum_helpers.dart';
import '../../../data/models/feedback_model.dart';
import '../../../data/models/feedbacks.dart';

part 'feedback_state.dart';

part 'feedback_cubit.freezed.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit(this._feedBackRepository) : super(const FeedbackState());
  final FeedBackRepository _feedBackRepository;

  Future<void> fetchFeedbacksCount(int userId) async {
    emit(state.copyWith(countSt: RequestStatus.loading));

    final response = await _feedBackRepository.fetchFeedBackCount(id: userId);

    response.fold(
      (l) {
        emit(
          state.copyWith(countSt: RequestStatus.error, errorText: l.message),
        );
      },
      (r) {
        emit(state.copyWith(countSt: RequestStatus.loaded, countFeedback: r));
      },
    );
  }

  Future<void> fetchFeedBackList(int userId) async {
    emit(state.copyWith(listSt: RequestStatus.loading));

    final response = await _feedBackRepository.fetchFeedBackList(id: userId);

    response.fold(
      (l) {
        emit(state.copyWith(listSt: RequestStatus.error, errorText: l.message));
      },
      (r) {
        emit(state.copyWith(listSt: RequestStatus.loaded, listFeedBack: r));
      },
    );
  }

  Future<void> addFeedBack({
    required FeedbackRequestModel feedBackRequest,
  }) async {
    emit(state.copyWith(addReviewSt: RequestStatus.loading));

    final response = await _feedBackRepository.addFeedBack(
      feedbackModel: feedBackRequest,
    );

    response.fold(
      (l) {
        emit(state.copyWith(addReviewSt: RequestStatus.error));
      },
      (r) {
        final oldFeedBacks = state.listFeedBack?.items ?? [];
        final list = state.listFeedBack?.copyWith(
          items: [...oldFeedBacks]..add(r),
        );
        emit(
          state.copyWith(addReviewSt: RequestStatus.loaded, listFeedBack: list),
        );
        showSuccessToast("Success");
        navigatorKey.currentContext?.pop();
      },
    );
  }
}
