import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../../../models/feedback.dart';
import '../../data/models/feedback_model.dart';
import '../../data/models/feedbacks.dart';

abstract class FeedBackRepository {
  Future<Either<Failure, int>> fetchFeedBackCount({required int id});

  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required int id,
  });

  Future<Either<Failure, FeedbackModel>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  });
}
