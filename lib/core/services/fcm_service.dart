// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:go_router/go_router.dart';
// import 'package:logger/logger.dart';
// import 'package:top_jobs/core/router/app_routes.dart';
// import 'package:top_jobs/core/router/route_names.dart';
// import 'package:top_jobs/core/services/storage_service.dart';
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await FcmNotificationService.instance.setUpFlutterNotification();
//   await FcmNotificationService.instance.showNotification(message);
// }
//
// class FcmNotificationService {
//   FcmNotificationService._();
//
//   static final FcmNotificationService instance = FcmNotificationService._();
//
//   final _messaging = FirebaseMessaging.instance;
//   final _localNotifications = FlutterLocalNotificationsPlugin();
//   bool _isFlutterLocalNotificationsInitialized = false;
//
//   Future<void> initialize() async {
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     /// request permission
//     await _requestPermission();
//
//     ///set up message andler
//     await _setUpMessageHandlers();
//     if (Platform.isIOS) {
//       final result = await _isIosRealDevice();
//       if (result) {
//         final token = await _messaging.getToken();
//         await StorageService.instance.putDeviceToken(token);
//       }
//     }
//     if (Platform.isAndroid) {
//       final token = await _messaging.getToken();
//       await StorageService.instance.putDeviceToken(token);
//     }
//   }
//
//   Future<void> _requestPermission() async {
//     final settings = await _messaging.requestPermission(
//       alert: true,
//       announcement: false,
//       sound: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: false,
//       provisional: false,
//     );
//   }
//
//   Future<void> setUpFlutterNotification() async {
//     if (_isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//
//     ///Android set up
//
//     const channel = AndroidNotificationChannel(
//       'channel_id',
//       'channel_name',
//       description: 'This is android channel',
//       importance: Importance.high,
//     );
//
//     await _localNotifications
//         .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin
//         >()
//         ?.createNotificationChannel(channel);
//
//     const initializationSettingsAndroid = AndroidInitializationSettings(
//       '@drawable/ic_notification',
//     );
//
//     ///Ios set up
//     final initializationSettingsDarwin = DarwinInitializationSettings(
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       requestAlertPermission: true,
//     );
//
//     final initializationSettings = InitializationSettings(
//       iOS: initializationSettingsDarwin,
//       android: initializationSettingsAndroid,
//     );
//
//     /// flutter notification set up navigating to page
//     await _localNotifications.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) {
//         var logger = Logger();
//         logger.w(details.data);
//         logger.d(details.payload);
//         logger.i("this is on didReceiveNotification");
//         GoRouter.of(navigatorKey.currentContext!).push(Routes.edit_profile);
//       },
//     );
//
//     _isFlutterLocalNotificationsInitialized = true;
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? androidNotification = message.notification?.android;
//     if (notification != null && androidNotification != null) {
//       await _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             'channel_id',
//             'channel_name',
//             channelDescription: 'This is description',
//             importance: Importance.high,
//             priority: Priority.high,
//             icon: '@drawable/bell',
//           ),
//           iOS: DarwinNotificationDetails(
//             presentAlert: true,
//             presentBadge: true,
//             presentSound: true,
//           ),
//         ),
//         payload: jsonEncode(message.data),
//       );
//     }
//   }
//
//   ///foreground message
//   Future<void> _setUpMessageHandlers() async {
//     FirebaseMessaging.onMessage.listen((event) {
//       showNotification(event);
//     });
//
//     ///background message
//     FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
//
//     ///opened app
//     final initialMessage = await _messaging.getInitialMessage();
//     var logger = Logger();
//     logger.i(initialMessage?.data.toString());
//     logger.w("initial message has");
//     logger.e("${initialMessage}");
//     logger.i(initialMessage==null);
//     if (initialMessage != null) {
//       _handleBackgroundMessage(initialMessage);
//     }
//   }
//
//   ///Navigating to page
//   _handleBackgroundMessage(RemoteMessage message) {
//     var logger = Logger();
//     logger.i(message.data);
//     logger.i(navigatorKey.currentContext == null);
//     logger.d("THis is  logger info");
//     GoRouter.of(navigatorKey.currentContext!).push(Routes.createVacancy);
//   }
// }
//
// Future<bool> _isIosRealDevice() async {
//   final deviceInfo = DeviceInfoPlugin();
//   final iosInfo = await deviceInfo.iosInfo;
//   return iosInfo.isPhysicalDevice;
// }
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:top_jobs/feature/messages/presentation/cubits/message_cubit/message_cubit.dart';

import '../../injection_container.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await FcmNotificationService.instance.setUpFlutterNotification();
  await FcmNotificationService.instance.showNotification(message);
  await FcmNotificationService.instance._storePendingNavigation(message.data);
}

class FcmNotificationService {
  FcmNotificationService._();

  static final FcmNotificationService instance = FcmNotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;
  final _logger = Logger();

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// Request permission
    final hasPermission = await _requestPermission();

    if (!hasPermission) {
      return;
    }

    /// Set up Flutter local notifications first
    await setUpFlutterNotification();

    /// Set up message handlers
    await _setUpMessageHandlers();

    // Get and store device token
    await _getAndStoreDeviceToken();

    // Check for pending navigation after app launch
    await _checkPendingNavigation();
  }

  Future<void> _getAndStoreDeviceToken() async {
    if (Platform.isIOS) {
      // final result = await _isIosRealDevice();

      final token = await _messaging.getToken();
      if (token != null) {
        await StorageService.instance.putDeviceToken(token);
      }
    } else if (Platform.isAndroid) {
      final token = await _messaging.getToken();
      if (token != null) {
        await StorageService.instance.putDeviceToken(token);
      }
    }
  }

  Future<bool> _requestPermission() async {
    try {
      final status = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        sound: true,
        badge: true,
        carPlay: true,
        criticalAlert: false,
        provisional: false,
      );

      _logger.i(
        'Notification permission status: ${status.authorizationStatus}',
      );

      return status.authorizationStatus == AuthorizationStatus.authorized ||
          status.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      _logger.d(e.toString());
      return false;
    }
  }

  Future<void> setUpFlutterNotification() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    /// Android setup
    const channel = AndroidNotificationChannel(
      'channel_id',
      'channel_name',
      description: 'This is android channel',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
    >()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid = AndroidInitializationSettings(
      '@drawable/ic_notification',
    );

    /// iOS setup
    const initializationSettingsDarwin = DarwinInitializationSettings(
      requestBadgePermission: true,
      requestSoundPermission: true,
      requestAlertPermission: true,
    );

    const initializationSettings = InitializationSettings(
      iOS: initializationSettingsDarwin,
      android: initializationSettingsAndroid,
    );

    /// Flutter notification setup with proper navigation handling
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _logger.d('Notification tapped with payload: ${details.payload}');
        _handleNotificationTap(details.payload);
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'This is description',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@drawable/bell',
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  /// Foreground and background message handlers
  Future<void> _setUpMessageHandlers() async {
    // Foreground message handler
    FirebaseMessaging.onMessage.listen((message) {
      _logger.i('Foreground message received: ${message.data}');
      navigatorKey.currentContext
          ?.read<NotificationCubit>().fetchNotifications();
      if (message.data['content'].toString().contains("message")) {
      navigatorKey.currentContext?.read<MessageCubit>()
      ?..reset()
      ..fetchMessages();
      }
      showNotification
      (
      message
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _logger.i('Background message opened app: ${message.data}');

      _handleBackgroundMessage(message);
    });

    // Handle message when app is opened from killed state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _logger.i('Initial message found: ${initialMessage.data}');
      Future.delayed(const Duration(milliseconds: 500), () {
        _handleBackgroundMessage(initialMessage);
      });
    }
  }

  /// Handle notification tap from local notification
  void _handleNotificationTap(String? payload) {
    if (payload == null) return;

    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      _navigateBasedOnData(data);
    } catch (e) {
      _logger.e('Error parsing notification payload: $e');
    }
  }

  /// Handle background message navigation
  void _handleBackgroundMessage(RemoteMessage message) {
    _logger.i('Handling background message: ${message.data}');
    _navigateBasedOnData(message.data);
  }

  /// Navigate based on notification data
  void _navigateBasedOnData(Map<String, dynamic> data) {
    // Wait for context to be available
    Future.doWhile(() async {
      if (navigatorKey.currentContext != null) {
        return false;
      }
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    }).then((_) {
      final context = navigatorKey.currentContext;
      if (context != null) {
        _performNavigation(context, data);
      } else {
        _logger.w('Context still null after waiting, storing for later');
        _storePendingNavigation(data);
      }
    });
  }

  /// Perform the actual navigation
  void _performNavigation(context, Map<String, dynamic> data) {
    try {
      final String? route = data['route'];
      final String? page = data['page'];
      final String? action = data['action'];
      final contentId = int.tryParse(data['content_id'].toString());

      _logger.d(
        'Navigation data - route: $route, page: $page, action: $action',
      );

      if (data['content'].toString().contains("message") &&
          (data['content'].toString().contains("vacancy") ||
              data['content'].toString().contains("service") ||
              data['content'].toString().contains("task")) &&
          contentId != null) {
        GoRouter.of(
          context,
        ).push(Routes.chat, extra: contentId);
      }

      if (data['content'].toString().contains("vacancy") &&
          !data['content'].toString().contains("message") &&
          contentId != null) {
        GoRouter.of(
          context,
        ).push("/vacancy-view?id=$contentId");
      }
      if (data['content'].toString().contains("service") &&
          !data['content'].toString().contains("message") &&
          contentId != null) {
        GoRouter.of(
          context,
        ).push("/service-view?id=$contentId");
      }
      if (data['content'].toString().contains("task") &&
          !data['content'].toString().contains("message") &&
          contentId != null) {
        GoRouter.of(
          context,
        ).push("/task-view?id=$contentId");
      }

      // if (route != null) {
      //   GoRouter.of(context).push(route);
      // } else if (page != null) {
      //   switch (page.toLowerCase()) {
      //     case 'profile':
      //     case 'edit_profile':
      //       GoRouter.of(context).push(Routes.edit_profile);
      //       break;
      //     case 'vacancy':
      //     case 'create_vacancy':
      //       GoRouter.of(context).push(Routes.createVacancy);
      //       break;
      //     default:
      //       // Default navigation if no specific page is mentioned
      //       GoRouter.of(context).push(Routes.edit_profile);
      //   }
      // } else {
      //   GoRouter.of(context).push(Routes.main);
      // }
    } catch (e) {
      _logger.e('Navigation error: $e');
    }
  }

  /// Store pending navigation data
  Future<void> _storePendingNavigation(Map<String, dynamic> data) async {
    try {
      await sl<StorageService>().putPendingKey(jsonEncode(data));
      _logger.i('Stored pending navigation data');
    } catch (e) {
      _logger.e('Error storing pending navigation: $e');
    }
  }

  /// Check and handle pending navigation after app initialization
  Future<void> _checkPendingNavigation() async {
    try {
      final pendingData = await sl<StorageService>().getPendingKey();
      if (pendingData != null) {
        final data = jsonDecode(pendingData) as Map<String, dynamic>;
        _logger.i('Found pending navigation data: $data');

        await sl<StorageService>().putPendingKey(null);
        Future.delayed(const Duration(milliseconds: 1000), () {
          _navigateBasedOnData(data);
        });
      }
    } catch (e) {
      _logger.e('Error checking pending navigation: $e');
    }
  }

  /// Check if notification permissions are granted
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
      >()
          ?.areNotificationsEnabled() ??
          false;
    }
    return true; // iOS handles permissions differently
  }
}
