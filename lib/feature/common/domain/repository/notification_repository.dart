import 'package:dartz/dartz.dart';

import '../../../../core/network/api_http.dart';
import '../../data/models/notifications.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, NotificationListResponse>> fetchNotifications({
    Map<String, dynamic>? queryParams,
  });

  Future<Either<Failure, void>> makeNotificationRead({
    required int notificationId,
  });
}
