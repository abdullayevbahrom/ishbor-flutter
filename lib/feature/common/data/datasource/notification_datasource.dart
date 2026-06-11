import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/common/data/models/notifications.dart';

abstract class NotificationsDataSource {
  Future<Either<Failure, NotificationListResponse>> fetchNotifications(
    Map<String, dynamic>? queryParams,
  );

  Future<Either<Failure, NotificationListResponse>>
  fetchNotificationsByContent({
    required String content,
    Map<String, dynamic>? queryParams,
  });

  Future<Either<Failure, void>> makeNotificationRead({
    required Object notificationId,
  });

  Future<Either<Failure, void>> makeNotificationReadByContent({
    required String content,
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
      debugPrint(
        '[DEBUG][notifications] fetch list content=all query=${queryParams ?? const {}}',
      );
      final response = await _dio.get(
        ApiConstants.notifications,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return Right(NotificationListResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, NotificationListResponse>>
  fetchNotificationsByContent({
    required String content,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      debugPrint(
        '[DEBUG][notifications] fetch by content content=$content query=${queryParams ?? const {}}',
      );
      final response = await _dio.get(
        ApiConstants.notificationsByContent(content),
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return Right(NotificationListResponse.fromMap(response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> makeNotificationRead({
    required Object notificationId,
  }) async {
    try {
      debugPrint(
        '[DEBUG][notifications] make read notificationId=${notificationId.toString()}',
      );
      final response = await _dio.post(
        ApiConstants.makeReadNotification(notificationId),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> makeNotificationReadByContent({
    required String content,
  }) async {
    try {
      debugPrint(
        '[DEBUG][notifications] make read by content content=$content',
      );
      final response = await _dio.post(
        ApiConstants.makeReadNotificationByContent(content),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
