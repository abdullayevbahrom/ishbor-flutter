import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/feedback_datasource.dart';
import 'package:top_jobs/feature/common/data/models/feedback_model.dart';
import 'package:top_jobs/feature/common/data/models/feedbacks.dart';
import 'package:top_jobs/feature/common/domain/repository/feedback_repository.dart';
import 'package:top_jobs/models/feedback.dart';

class FeedBackRepositoryImpl extends FeedBackRepository {
  final FeedBackDataSource _feedBackDataSource;

  FeedBackRepositoryImpl(this._feedBackDataSource);

  @override
  Future<Either<Failure, int>> fetchFeedBackCount({required int id}) async {
    final response = await _feedBackDataSource.fetchFeedBackCount(id: id);

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required int id,
  }) async {
    final response = await _feedBackDataSource.fetchFeedBackList(id: id);
    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, FeedbackModel>> addFeedBack({required FeedbackRequestModel feedbackModel}) async{
   final response= await _feedBackDataSource.addFeedBack(feedbackModel: feedbackModel);
   return response.fold(
         (l) {
       return Left(Failure(message: l.message));
     },
         (r) {
       return Right(r);
     },
   );

  }
}
