import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/feedback_model.dart';
import '../../data/models/feedbacks.dart';

abstract class FeedBackRepository {
  Future<Either<Failure, int>> fetchFeedBackCount({required String id});

  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required String id,
  });

  Future<Either<Failure, void>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  });
}
