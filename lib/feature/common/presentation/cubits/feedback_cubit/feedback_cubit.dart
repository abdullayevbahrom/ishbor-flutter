import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
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

  Future<void> fetchFeedbacksCount(String userId) async {
    emit(state.copyWith(countSt: RequestStatus.loading, userId: userId));
    if (kDebugMode) {
      debugPrint('[DEBUG][feedback][count] action=count userId=$userId');
    }

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

  Future<void> fetchFeedBackList(String userId) async {
    emit(state.copyWith(listSt: RequestStatus.loading, userId: userId));
    if (kDebugMode) {
      debugPrint('[DEBUG][feedback][list] action=list userId=$userId');
    }

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
    if (kDebugMode) {
      debugPrint(
        '[DEBUG][feedback][create] action=create receiverType=${feedBackRequest.receiverType} receiverId=${feedBackRequest.receiverId} like=${feedBackRequest.like ?? false} dislike=${feedBackRequest.dislike ?? false} messageLength=${feedBackRequest.message?.length ?? 0}',
      );
    }

    final response = await _feedBackRepository.addFeedBack(
      feedbackModel: feedBackRequest,
    );

    await response.fold(
      (l) async {
        emit(state.copyWith(addReviewSt: RequestStatus.error));
        if (kDebugMode) {
          debugPrint('[WARN][feedback][create][error] ${l.message}');
        }
      },
      (_) async {
        emit(state.copyWith(addReviewSt: RequestStatus.loaded));
        final userId = state.userId ?? feedBackRequest.receiverId;
        if (userId != null && userId.isNotEmpty) {
          await fetchFeedBackList(userId);
          await fetchFeedbacksCount(userId);
        }
        if (kDebugMode) {
          debugPrint('[DEBUG][feedback][create] success');
        }
        showSuccessToast("Success");
        navigatorKey.currentContext?.pop();
      },
    );
  }
}
