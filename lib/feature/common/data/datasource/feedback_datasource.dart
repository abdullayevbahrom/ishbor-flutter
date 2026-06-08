import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';

import '../models/feedback_model.dart';
import '../models/feedbacks.dart';

abstract class FeedBackDataSource {
  Future<Either<Failure, int>> fetchFeedBackCount({required String id});

  Future<Either<Failure, PaginatedFeedbackResponse>> fetchFeedBackList({
    required String id,
  });

  Future<Either<Failure, void>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  });
}

class FeedBackDataSourceImpl extends FeedBackDataSource {
  final Dio _dio;

  FeedBackDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, int>> fetchFeedBackCount({required String id}) async {
    try {
      if (kDebugMode) {
        debugPrint(
          '[FEEDBACK][count] GET ${ApiConstants.userFeedbacksCount(id)}',
        );
      }
      final response = await _dio.get(ApiConstants.userFeedbacksCount(id));

      if (response.statusCode == 200) {
        final payload =
            response.data is Map<String, dynamic>
                ? (response.data['data'] ?? response.data)
                : response.data;
        if (payload is int) {
          return Right(payload);
        }
        if (payload is String) {
          return Right(int.tryParse(payload) ?? 0);
        }
        if (payload is Map<String, dynamic>) {
          final count = payload['count'] ?? payload['total_count'];
          return Right(int.tryParse('$count') ?? 0);
        }
        return const Right(0);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        }
        return Left(Failure(message: response.data));
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
    required String id,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('[FEEDBACK][list] GET ${ApiConstants.userFeedbacks(id)}');
      }
      final response = await _dio.get(ApiConstants.userFeedbacks(id));

      if (response.statusCode == 200) {
        return Right(PaginatedFeedbackResponse.fromJson(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        }
        return Left(Failure(message: response.data));
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
  Future<Either<Failure, void>> addFeedBack({
    required FeedbackRequestModel feedbackModel,
  }) async {
    try {
      if (kDebugMode) {
        debugPrint('[FIX][FEEDBACK][create] POST ${ApiConstants.feedbacks}');
      }
      final response = await _dio.post(
        ApiConstants.feedbacks,
        data: feedbackModel.toJson(),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        if (kDebugMode) {
          debugPrint(
            '[FIX][FEEDBACK][create] accepted receiverType=${feedbackModel.receiverType} receiverId=${feedbackModel.receiverId}',
          );
        }
        return const Right(null);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      if (kDebugMode) {
        debugPrint(
          '[FIX][FEEDBACK][create][error] receiverType=${feedbackModel.receiverType} receiverId=${feedbackModel.receiverId} message=${failure.message}',
        );
      }
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
