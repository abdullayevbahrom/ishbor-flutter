import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/notifications.dart';

abstract class NotificationsDataSource {
  Future<Either<Failure, NotificationListResponse>> fetchNotifications(
    Map<String, dynamic>? queryParams,
  );

  Future<Either<Failure, void>> makeNotificationRead({
    required int notificationId,
  });
}

class NotificationsDataSourceImpl extends NotificationsDataSource {
  final Dio _dio;

  NotificationsDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, NotificationListResponse>> fetchNotifications(
    Map<String, dynamic>? queryParams,
  ) async {
    try {
      final response = await _dio.get(
        ApiConstants.notifications,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return Right(NotificationListResponse.fromMap(response.data));
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
  Future<Either<Failure, void>> makeNotificationRead({
    required int notificationId,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.makeReadNotification(notificationId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
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
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
