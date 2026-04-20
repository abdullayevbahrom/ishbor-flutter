import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/models/feedback.dart';

import '../models/feedback_model.dart';
import '../models/feedbacks.dart';

abstract class FeedBackDataSource {
  Future<Either<Failure, int>> fetchFeedBackCount({required int id});

  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required int id,
  });

  Future<Either<Failure, FeedbackModel>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  });
}

class FeedBackDataSourceImpl extends FeedBackDataSource {
  final Dio _dio;

  FeedBackDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, int>> fetchFeedBackCount({required int id}) async {
    try {
      final response = await _dio.get(ApiConstants.userFeedbacksCount(id));

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required int id,
  }) async {
    try {
      final response = await _dio.get(ApiConstants.userFeedbacks(id));

      if (response.statusCode == 200) {
        return Right(PaginatedFeedbackResponse.fromJson(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, FeedbackModel>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.feedbacks,
        data: feedbackModel.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(FeedbackModel.fromMap(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
