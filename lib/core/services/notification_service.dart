// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationsService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   void requestNotificationPermissions() {
//     notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.requestNotificationsPermission();
//   }
//
//   Future<void> initNotifications() async {
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('ic_launcher');
//
//     DarwinInitializationSettings initializationSettingsIos =
//         const DarwinInitializationSettings(
//           requestAlertPermission: true,
//           requestSoundPermission: true,
//           requestBadgePermission: true,
//         );
//
//     var initializationSettings = InitializationSettings(
//       iOS: initializationSettingsIos,
//       android: initializationSettingsAndroid,
//     );
//
//     await notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {},
//     );
//   }
//
//   notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         priority: Priority.high,
//         importance: Importance.max,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }
//
//   Future<void> showNotifications({
//     required String body,
//     required String title,
//   }) async {
//     return notificationsPlugin.show(
//       0,
//       title,
//       body,
//       await notificationDetails(),
//     );
//   }
// }
