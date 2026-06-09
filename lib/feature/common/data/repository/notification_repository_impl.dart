import 'package:dartz/dartz.dart';

import 'package:top_jobs/core/network/api_http.dart';
import 'package:top_jobs/feature/common/data/datasource/notification_datasource.dart';

import 'package:top_jobs/feature/common/data/models/notifications.dart';

import '../../domain/repository/notification_repository.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsDataSource _notificationsDataSource;

  NotificationsRepositoryImpl(this._notificationsDataSource);

  @override
  Future<Either<Failure, NotificationListResponse>> fetchNotifications({
    Map<String, dynamic>? queryParams,
  }) {
    return _notificationsDataSource.fetchNotifications(queryParams);
  }

  @override
  Future<Either<Failure, NotificationListResponse>> fetchNotificationsByContent({
    required String content,
    Map<String, dynamic>? queryParams,
  }) {
    return _notificationsDataSource.fetchNotificationsByContent(
      content: content,
      queryParams: queryParams,
    );
  }

  @override
  Future<Either<Failure, void>> makeNotificationRead({
    required Object notificationId,
  }) {
    return _notificationsDataSource.makeNotificationRead(
      notificationId: notificationId,
    );
  }

  @override
  Future<Either<Failure, void>> makeNotificationReadByContent({
    required String content,
  }) {
    return _notificationsDataSource.makeNotificationReadByContent(
      content: content,
    );
  }
}
