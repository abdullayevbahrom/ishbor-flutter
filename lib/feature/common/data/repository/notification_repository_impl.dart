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
  }) async {
    final response = await _notificationsDataSource.fetchNotifications(
      queryParams,
    );
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
  Future<Either<Failure, void>> makeNotificationRead({
    required int notificationId,
  }) async {
    final response = await _notificationsDataSource.makeNotificationRead(
      notificationId: notificationId,
    );
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
