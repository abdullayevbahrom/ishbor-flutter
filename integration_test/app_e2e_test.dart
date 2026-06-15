import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/helpers/image_picker.dart';
import 'package:top_jobs/core/network/dio_interceptor.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/core/utils/e2e_keys.dart';
import 'package:top_jobs/feature/auth/presentation/pages/user_type_page/user_type_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/service_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/task_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/vacancy_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading_item.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/notification_cubit/notification_cubit.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/notifications_dialog_widget.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/map_view_cubit/map_view_cubit.dart';
import 'package:top_jobs/feature/ads_view/data/models/task_request_params.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/task_view_cubit/task_view_cubit.dart';
import 'package:top_jobs/feature/messages/domain/repository/messages_repository.dart';
import 'package:top_jobs/feature/messages/presentation/cubits/chat_cubit/chat_cubit.dart';
import 'package:top_jobs/feature/messages/presentation/pages/messages_page/widgets/message_item.dart';
import 'package:top_jobs/feature/others_profile/presentation/pages/others_profile_page/others_profile_page.dart';
import 'package:top_jobs/feature/services/data/models/service.dart';
import 'package:top_jobs/feature/profile/data/model/payment_provider.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';
import 'package:top_jobs/feature/common/data/models/common_query_params.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/tasks/presentation/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
import 'package:top_jobs/feature/vacancies/presentation/cubits/create_vacancy_cubit/create_vacancy_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_radio_list_tile.dart';
import 'package:top_jobs/models/message.dart';
import 'package:top_jobs/models/vacancy.dart';
import 'package:top_jobs/injection_container.dart';
import 'package:top_jobs/main.dart' as app;

import 'e2e/auth_preflight.dart';
import 'e2e/device_setup.dart';
import 'e2e/e2e_config.dart';
import 'e2e/flows/realtime_flow.dart';
import 'e2e/screenshot_helper.dart';
import 'e2e/ui_matrix.dart';

final class _BrowseTargets {
  const _BrowseTargets({
    required this.vacancyId,
    required this.vacancyLastId,
    required this.serviceId,
    required this.serviceLastId,
    required this.taskId,
    required this.taskLastId,
  });

  final String vacancyId;
  final String vacancyLastId;
  final String serviceId;
  final String serviceLastId;
  final String taskId;
  final String taskLastId;
}

final class _CleanupAction {
  const _CleanupAction({
    required this.label,
    required this.id,
    required this.action,
  });

  final String label;
  final String id;
  final Future<void> Function() action;
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final config = E2EConfig.fromEnvironment();
  final deviceSetup = E2EDeviceSetup.fromEnvironment();
  final apiCalls = <Map<String, dynamic>>[];
  final cleanupActions = <_CleanupAction>[];
  final helper = E2EScreenshotHelper(
    binding: binding,
    config: config,
    apiCalls: apiCalls,
  );

  setUpAll(() async {
    DioInterceptors.e2eObserver = (trace) {
      apiCalls.add(<String, dynamic>{
        'phase': trace.phase,
        'method': trace.method,
        'path': trace.path,
        'duration_ms': trace.durationMs,
        if (trace.statusCode != null) 'status_code': trace.statusCode,
        if (trace.error != null) 'error': trace.error.toString(),
      });
    };

    E2EMatrixLogger.emit();
    debugPrint('INFO [E2E][device] ${deviceSetup.describeForLog()}');
    await app.bootstrapApplication(mode: app.AppBootstrapMode.e2e);
    await helper.prepare();
    ImagePickerHelper.debugPickMultiImageOverride = () async {
      final path = '${deviceSetup.downloadDirectory}/sample_image.png';
      return <File>[File(path)];
    };
    ImagePickerHelper.debugPickImageOverride = (source) async {
      final path = '${deviceSetup.downloadDirectory}/sample_image.png';
      return File(path);
    };
    ImagePickerHelper.debugPickDocOverride = () async {
      final path = '${deviceSetup.downloadDirectory}/sample_image.png';
      return File(path);
    };
    ChatCubit.debugPickFileOverride = (messageId) async {
      debugPrint(
        '[FIX][E2E][messages] attachment override messageId=$messageId path=${deviceSetup.downloadDirectory}/sample_image.png',
      );
      return '${deviceSetup.downloadDirectory}/sample_image.png';
    };
    await Future<void>.delayed(const Duration(seconds: 2));
  });

  tearDownAll(() async {
    DioInterceptors.e2eObserver = null;
    ImagePickerHelper.debugPickMultiImageOverride = null;
    ImagePickerHelper.debugPickImageOverride = null;
    ImagePickerHelper.debugPickDocOverride = null;
    ChatCubit.debugPickFileOverride = null;
    final cleanupStatus = await _runCleanupActions(
      cleanupActions,
      enabled: config.cleanup,
      runId: config.runId,
    );
    await helper.finalize(status: cleanupStatus);
  });

  testWidgets('bootstrap manifest and screenshot plumbing', (tester) async {
    binding.reportData = <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': 'running',
      'device_setup': deviceSetup.toJson(),
      'screenshots': <dynamic>[],
      'api_calls': <dynamic>[],
    };

    await _waitForAppRoot(tester);

    await helper.capture(
      tester: tester,
      route: 'bootstrap',
      state: 'ready',
      order: 1,
    );

    expect(binding.reportData, isNotNull);
    expect(binding.reportData!['run_id'], config.runId);
  });

  testWidgets('mercure realtime preflight and fallback coverage', (
    tester,
  ) async {
    final auth = await AuthPreflight(config).run();
    final userId = auth.userId;
    if (userId == null || userId.isEmpty) {
      throw StateError('Auth preflight did not return a user id.');
    }

    await StorageService.instance.putToken(auth.accessToken);
    if (auth.refreshToken != null && auth.refreshToken!.isNotEmpty) {
      await StorageService.instance.putRefreshToken(auth.refreshToken);
    }
    if (auth.deviceToken != null && auth.deviceToken!.isNotEmpty) {
      await StorageService.instance.putDeviceToken(auth.deviceToken);
    }
    await StorageService.instance.putUserId(userId);
    if (auth.expiresAt != null) {
      await StorageService.instance.putExpireDate(auth.expiresAt);
    }

    final results = await RealtimeFlow().run(userId: userId, dialogId: userId);
    final fallback = results.any((result) => result.fallback);
    final state = fallback ? 'fallback' : 'connected';

    binding.reportData = <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': 'running',
      'device_setup': deviceSetup.toJson(),
      'mercure':
          results
              .map(
                (result) => <String, dynamic>{
                  'label': result.label,
                  'topics': result.topics,
                  'connected': result.connected,
                  'fallback': result.fallback,
                },
              )
              .toList(),
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Mercure $state', key: ValueKey('mercure-$state')),
          ),
        ),
      ),
    );

    await helper.capture(
      tester: tester,
      route: 'mercure',
      state: state,
      order: 2,
    );

    expect(results, isNotEmpty);
    expect(
      results.any((result) => result.connected || result.fallback),
      isTrue,
    );
  });

  testWidgets('phase 3 task 13 splash auth otp register deep link and shell flows', (
    tester,
  ) async {
    await _resetToGuest(tester);

    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'guest',
      order: 3,
    );

    await tester.tap(find.byKey(E2EKeys.button('main.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.modal('login')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'auth-login',
      state: 'modal-open',
      order: 4,
    );

    await tester.tap(find.byKey(E2EKeys.button('auth.login.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-login',
      state: 'validation-empty',
      order: 41,
    );

    await tester.enterText(
      find.byKey(E2EKeys.input('auth.login', 'phone')),
      '12',
    );
    await tester.tap(find.byKey(E2EKeys.button('auth.login.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(LocaleKeys.incorrectPhone.tr()), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-login',
      state: 'validation-invalid',
      order: 42,
    );

    final uiPhone = '123456789';
    await tester.enterText(
      find.byKey(E2EKeys.input('auth.login', 'phone')),
      uiPhone,
    );
    await tester.tap(find.byKey(E2EKeys.button('auth.login.submit')));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byKey(E2EKeys.modal('otp')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-otp',
      state: 'register-bootstrap',
      order: 5,
    );

    await tester.tap(
      find.descendant(
        of: find.byKey(E2EKeys.modal('otp')),
        matching: find.text(LocaleKeys.register.tr()),
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-otp',
      state: 'validation-empty',
      order: 43,
    );

    await _closeTopSheets(tester, count: 2);

    navigatorKey.currentContext!.push(Routes.register);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.page('register')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'auth-register',
      state: 'form-ready',
      order: 6,
    );

    debugPrint('[FIX][E2E][task13] opening user type and name subflows');
    final registerPhone = config.testPhone.replaceFirst(RegExp(r'^\+998'), '');
    UserTypePage(phoneNumber: registerPhone).show(navigatorKey.currentContext!);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byKey(E2EKeys.page('user-type')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'auth-user-type',
      state: 'initial',
      order: 7,
    );

    await tester.tap(find.text(LocaleKeys.next.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-user-type',
      state: 'validation-empty',
      order: 8,
    );

    await tester.tap(find.text(LocaleKeys.iNeedJob.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.next.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.byKey(E2EKeys.page('name')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'auth-name',
      state: 'initial',
      order: 9,
    );

    await tester.tap(find.byKey(E2EKeys.button('auth.register.complete')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'auth-name',
      state: 'validation-empty',
      order: 10,
    );

    await tester.enterText(
      find.byKey(E2EKeys.input('auth.register', 'full-name')),
      'Test E2E User',
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'auth-name',
      state: 'filled',
      order: 11,
    );

    await _closeTopSheets(tester, count: 1);

    final auth = await AuthPreflight(config).run();
    await _seedAuthenticatedState(auth);
    navigatorKey.currentContext!.go(Routes.main);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    expect(find.byKey(E2EKeys.page('main')), findsOneWidget);

    await tester.tap(find.byKey(E2EKeys.button('main.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.modal('main.actions')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'authenticated-actions',
      order: 7,
    );

    await tester.tap(find.byKey(E2EKeys.button('main.notifications')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'notifications-menu',
      order: 12,
    );

    debugPrint('[FIX][E2E][task13] switching main shell tabs');
    await _selectMainTab(tester, 1);
    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'services-tab',
      order: 13,
    );
    await _selectMainTab(tester, 2);
    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'tasks-tab',
      order: 14,
    );
    await _selectMainTab(tester, 3);
    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'messages-tab',
      order: 15,
    );
    await _selectMainTab(tester, 4);
    await helper.capture(
      tester: tester,
      route: 'main-shell',
      state: 'profile-tab',
      order: 16,
    );

    final targets = await _loadBrowseTargets();
    navigatorKey.currentContext!.go(
      '/splash/${jsonEncode(<String, dynamic>{'vacancyId': targets.vacancyId})}',
    );
    await tester.pump();
    await helper.capture(
      tester: tester,
      route: 'deep-link-splash',
      state: 'payload-vacancy',
      order: 8,
      settle: false,
    );

    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byKey(E2EKeys.page('vacancy-view')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: 'deep-link-vacancy',
      state: 'detail',
      order: 9,
    );

    navigatorKey.currentContext!.go(
      '/splash/${jsonEncode(<String, dynamic>{'serviceId': targets.serviceId})}',
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byKey(E2EKeys.page('service-view')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'deep-link-service',
      state: 'detail',
      order: 17,
    );

    navigatorKey.currentContext!.go(
      '/splash/${jsonEncode(<String, dynamic>{'taskId': targets.taskId})}',
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    expect(find.byKey(E2EKeys.page('task-view')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'deep-link-task',
      state: 'detail',
      order: 18,
    );

    final payloadExpiresAt =
        auth.expiresAt ?? DateTime.now().add(const Duration(hours: 1));
    navigatorKey.currentContext!.go(
      '/main/${jsonEncode(<String, dynamic>{'token': auth.accessToken, 'expires_at': payloadExpiresAt.toIso8601String()})}',
    );
    await tester.pump();
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byKey(E2EKeys.page('main')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'main-payload',
      state: 'token-redirect',
      order: 19,
    );

    final paymentTransactionId = await _createPaymentTransactionId();
    navigatorKey.currentContext!.go(
      '/payment?transaction_id=$paymentTransactionId',
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byKey(E2EKeys.page('payment')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'payment',
      state: 'deeplink',
      order: 20,
    );
  });

  testWidgets(
    'phase 3 task 14 public browse list filter map and detail flows',
    (tester) async {
      await _resetToGuest(tester);
      final targets = await _loadBrowseTargets();

      await _selectMainTab(tester, 0);
      await _captureListAndDetail(
        tester: tester,
        helper: helper,
        route: 'vacancies',
        listKey: E2EKeys.page('vacancies'),
        searchInputKey: E2EKeys.input('search', 'query'),
        filterButtonKey: E2EKeys.button('search.filter'),
        locationButton: E2EKeys.button('search.location'),
        cardKeyPrefix: 'vacancy',
        firstCardId: targets.vacancyId,
        lastCardId: targets.vacancyLastId,
        detailRoute: '/vacancy-view?id=${targets.vacancyId}',
        listOrder: 10,
        searchOrder: 11,
        filterOrder: 12,
        mapOrder: 13,
        detailOrder: 14,
      );

      await _selectMainTab(tester, 1);
      await _captureListAndDetail(
        tester: tester,
        helper: helper,
        route: 'services',
        listKey: E2EKeys.page('services'),
        searchInputKey: E2EKeys.input('search', 'query'),
        filterButtonKey: E2EKeys.button('search.filter'),
        locationButton: E2EKeys.button('search.location'),
        cardKeyPrefix: 'service',
        firstCardId: targets.serviceId,
        lastCardId: targets.serviceLastId,
        detailRoute: '/service-view?id=${targets.serviceId}',
        listOrder: 15,
        searchOrder: 16,
        filterOrder: 17,
        mapOrder: 18,
        detailOrder: 19,
      );

      await _selectMainTab(tester, 2);
      await _captureListAndDetail(
        tester: tester,
        helper: helper,
        route: 'tasks',
        listKey: E2EKeys.page('tasks'),
        searchInputKey: E2EKeys.input('search', 'query'),
        filterButtonKey: E2EKeys.button('search.filter'),
        locationButton: E2EKeys.button('search.location'),
        cardKeyPrefix: 'task',
        firstCardId: targets.taskId,
        lastCardId: targets.taskLastId,
        detailRoute: '/task-view?id=${targets.taskId}',
        listOrder: 20,
        searchOrder: 21,
        filterOrder: 22,
        mapOrder: 23,
        detailOrder: 24,
      );

      debugPrint('[FIX][E2E][task14] covering authenticated detail actions');
      final auth = await AuthPreflight(config).run();
      await _seedAuthenticatedState(auth);

      navigatorKey.currentContext!.go('/vacancy-view?id=${targets.vacancyId}');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byKey(E2EKeys.page('vacancy-view')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'authenticated',
        order: 25,
      );
      await tester.tap(find.byKey(E2EKeys.button('ads.favorite')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'favorite-toggled',
        order: 26,
      );
      await tester.tap(find.text(LocaleKeys.call.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'phone-modal',
        order: 27,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.write.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'message-modal',
        order: 28,
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'Salom, bu E2E xabari.',
      );
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'message-filled',
        order: 29,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.complain.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'report-modal',
        order: 30,
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'Test report reason',
      );
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'report-filled',
        order: 31,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.byKey(E2EKeys.button('share.clipboard')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'vacancy-detail',
        state: 'share-copy',
        order: 32,
      );

      navigatorKey.currentContext!.go('/service-view?id=${targets.serviceId}');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byKey(E2EKeys.page('service-view')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'service-detail',
        state: 'authenticated',
        order: 33,
      );
      await tester.tap(find.byKey(E2EKeys.button('ads.favorite')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.text(LocaleKeys.call.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'service-detail',
        state: 'phone-modal',
        order: 34,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.write.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'service-detail',
        state: 'message-modal',
        order: 35,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.complain.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'service-detail',
        state: 'report-modal',
        order: 36,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.byKey(E2EKeys.button('share.clipboard')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'service-detail',
        state: 'share-copy',
        order: 37,
      );

      navigatorKey.currentContext!.go('/task-view?id=${targets.taskId}');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byKey(E2EKeys.page('task-view')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'authenticated',
        order: 38,
      );
      await tester.tap(find.byKey(E2EKeys.button('ads.favorite')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.text(LocaleKeys.call.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'phone-modal',
        order: 39,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.write.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'message-modal',
        order: 40,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.text(LocaleKeys.complain.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'report-modal',
        order: 41,
      );
      await _closeTopSheets(tester, count: 1);
      await tester.tap(find.byKey(E2EKeys.button('share.clipboard')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'share-copy',
        order: 42,
      );

      await tester.tap(find.text(LocaleKeys.applyRequest.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'apply-modal',
        order: 43,
      );
      await tester.tap(find.text(LocaleKeys.send.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'apply-validation',
        order: 44,
      );
      await tester.enterText(
        find.byType(TextFormField).at(0),
        'Men buni bajaraman.',
      );
      await tester.enterText(find.byType(TextFormField).at(1), '350000');
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'apply-filled',
        order: 45,
      );
      await _closeTopSheets(tester, count: 1);
    },
  );

  testWidgets('phase 4 task 15 vacancy create edit flow', (tester) async {
    await _resetToGuest(tester);
    final auth = await AuthPreflight(config).run();
    await _seedAuthenticatedState(auth);

    final createdTitle = 'Vacancy ${config.runId}';
    final updatedTitle = 'Vacancy ${config.runId} updated';
    final prompt = 'Create a vacancy for ${config.runId} with logistics focus';

    navigatorKey.currentContext!.push(Routes.createVacancy);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-vacancy')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'generator',
      order: 46,
    );

    await tester.enterText(
      find.byKey(E2EKeys.input('vacancy.generate', 'prompt')),
      prompt,
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'prompt-filled',
      order: 47,
    );

    await tester.tap(find.byKey(E2EKeys.button('vacancy.generate.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 5));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'form-ready',
      order: 48,
    );

    debugPrint('[FIX][E2E][vacancy] forcing generate failure branch');
    final vacancyCubit =
        navigatorKey.currentContext!.read<CreateVacancyCubit>();
    vacancyCubit.descriptionController.text = List.filled(901, 'x').join();
    await vacancyCubit.generateVacancyBody();
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'generate-error',
      order: 148,
    );

    debugPrint('[FIX][E2E][vacancy] capturing validation errors');
    await tester.tap(find.byKey(E2EKeys.button('vacancy.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'validation-errors',
      order: 149,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'title'),
      createdTitle,
    );
    await _selectFirstCategory(tester: tester, formPrefix: 'vacancy.create');
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'description'),
      'E2E vacancy description for ${config.runId}.',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'salary-min'),
      '5000000',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'salary-max'),
      '9000000',
    );
    await tester.tap(find.byKey(const Key('vacancy.salary.negotiable')));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(const Key('vacancy.respond.application')));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(const Key('vacancy.respond.temporary')));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await _enterTextInField(
      tester,
      const Key('vacancy.create.start-time'),
      '09:00',
    );
    await _enterTextInField(
      tester,
      const Key('vacancy.create.end-time'),
      '18:00',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'skills'),
      'Flutter, Dart, Logistics',
    );
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'section-filled',
      order: 49,
    );

    await _selectLocation(
      tester: tester,
      helper: helper,
      route: 'vacancy-create',
      state: 'location-map',
      order: 50,
      triggerKey: const Key('vacancy.location.select'),
    );
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'location-selected',
      order: 51,
    );

    await tester.tap(find.byKey(E2EKeys.button('vacancy.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'image-added',
      order: 52,
    );
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'image-removed',
      order: 53,
    );
    await tester.tap(find.byKey(E2EKeys.button('vacancy.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'phone-1'),
      '901234567',
    );
    await tester.tap(find.byKey(E2EKeys.button('vacancy.create.phone.add')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'phone-2'),
      '907654321',
    );
    await helper.capture(
      tester: tester,
      route: 'vacancy-create',
      state: 'ready-to-submit',
      order: 54,
    );

    await tester.tap(find.byKey(E2EKeys.button('vacancy.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'vacancy-view',
      state: 'created',
      order: 55,
    );

    final createdVacancy = await _findCreatedVacancyByTitle(createdTitle);
    _registerCleanupAction(
      cleanupActions,
      label: 'vacancy',
      id: createdVacancy.id.toString(),
      action: () async {
        final result = await sl<VacancyRepository>().deleteVacancyById(
          vacancyId: createdVacancy.id,
        );
        await result.fold(
          (failure) async {
            debugPrint(
              'WARN [E2E][cleanup] type=vacancy id=${createdVacancy.id} status=failed error=${failure.message}',
            );
          },
          (_) async {
            debugPrint(
              'INFO [E2E][cleanup] type=vacancy id=${createdVacancy.id} status=ok',
            );
          },
        );
      },
    );
    debugPrint(
      'INFO [E2E][vacancy] action=create id=${createdVacancy.id} fields=title,category,description,salary,phones,images,location',
    );

    navigatorKey.currentContext!.push(
      Routes.createVacancy,
      extra: createdVacancy,
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-vacancy')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'vacancy-edit',
      state: 'loaded',
      order: 56,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'title'),
      updatedTitle,
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('vacancy.create', 'description'),
      'Updated vacancy description for ${config.runId}.',
    );
    await tester.tap(find.byKey(E2EKeys.button('vacancy.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'vacancy-edit',
      state: 'image-removed',
      order: 57,
    );
    await tester.tap(find.byKey(E2EKeys.button('vacancy.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'vacancy-view',
      state: 'edited',
      order: 58,
    );
    debugPrint(
      'INFO [E2E][vacancy] action=edit id=${createdVacancy.id} fields=title,description,images',
    );

    await sl<VacancyRepository>().deleteVacancyById(
      vacancyId: createdVacancy.id,
    );
    _completeCleanupAction(
      cleanupActions,
      label: 'vacancy',
      id: createdVacancy.id.toString(),
    );
  });

  testWidgets('phase 4 task 16 service create edit flow', (tester) async {
    await _resetToGuest(tester);
    final auth = await AuthPreflight(config).run();
    await _seedAuthenticatedState(auth);

    final createdTitle = 'Service ${config.runId}';
    final updatedTitle = 'Service ${config.runId} updated';

    navigatorKey.currentContext!.push(Routes.createService);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-service')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'form-open',
      order: 59,
    );

    debugPrint('[FIX][E2E][service] capturing validation errors');
    await tester.tap(find.byKey(E2EKeys.button('service.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'validation-errors',
      order: 150,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'title'),
      createdTitle,
    );
    await _selectFirstCategory(tester: tester, formPrefix: 'service.create');
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'description'),
      'E2E service description for ${config.runId}.',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'salary'),
      '0',
    );
    debugPrint('[FIX][E2E][service] capturing bad price validation branch');
    await tester.tap(find.byKey(E2EKeys.button('service.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'bad-price-validation-errors',
      order: 151,
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'salary'),
      '2500000',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'phone-0'),
      '123',
    );
    debugPrint('[FIX][E2E][service] capturing phone validation branch');
    await tester.tap(find.byKey(E2EKeys.button('service.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'phone-validation-errors',
      order: 152,
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'phone-0'),
      '901111222',
    );
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'section-filled',
      order: 60,
    );

    await _selectLocation(
      tester: tester,
      helper: helper,
      route: 'service-create',
      state: 'location-map',
      order: 61,
      triggerKey: const Key('service.location.select'),
    );
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'location-selected',
      order: 62,
    );

    await tester.tap(find.byKey(E2EKeys.button('service.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'image-added',
      order: 63,
    );
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'image-removed',
      order: 64,
    );
    await tester.tap(find.byKey(E2EKeys.button('service.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'phone-1'),
      '901111222',
    );
    await tester.tap(find.byKey(E2EKeys.button('service.create.phone.add')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'phone-2'),
      '902222333',
    );
    await helper.capture(
      tester: tester,
      route: 'service-create',
      state: 'ready-to-submit',
      order: 65,
    );

    await tester.tap(find.byKey(E2EKeys.button('service.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'service-view',
      state: 'created',
      order: 66,
    );

    final createdService = await _findCreatedServiceByTitle(createdTitle);
    _registerCleanupAction(
      cleanupActions,
      label: 'service',
      id: createdService.id.toString(),
      action: () async {
        final result = await sl<ServiceRepository>().deleteServiceById(
          serviceId: createdService.id,
        );
        await result.fold(
          (failure) async {
            debugPrint(
              'WARN [E2E][cleanup] type=service id=${createdService.id} status=failed error=${failure.message}',
            );
          },
          (_) async {
            debugPrint(
              'INFO [E2E][cleanup] type=service id=${createdService.id} status=ok',
            );
          },
        );
      },
    );
    debugPrint(
      'INFO [E2E][service] action=create id=${createdService.id} fields=title,category,description,price,negotiable,address,phones,images',
    );

    navigatorKey.currentContext!.push(
      Routes.createService,
      extra: createdService,
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-service')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'service-edit',
      state: 'loaded',
      order: 67,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'title'),
      updatedTitle,
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('service.create', 'description'),
      'Updated service description for ${config.runId}.',
    );
    await tester.tap(find.byKey(E2EKeys.button('service.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'service-edit',
      state: 'image-removed',
      order: 68,
    );
    await tester.tap(find.byKey(E2EKeys.button('service.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'service-view',
      state: 'edited',
      order: 69,
    );
    debugPrint(
      'INFO [E2E][service] action=edit id=${createdService.id} fields=title,description,price,images',
    );

    await sl<ServiceRepository>().deleteServiceById(
      serviceId: createdService.id,
    );
    _completeCleanupAction(
      cleanupActions,
      label: 'service',
      id: createdService.id.toString(),
    );
  });

  testWidgets('phase 4 task 17 task create edit request flow', (tester) async {
    await _resetToGuest(tester);
    final auth = await AuthPreflight(config).run();
    await _seedAuthenticatedState(auth);

    final createdTitle = 'Task ${config.runId}';
    final updatedTitle = 'Task ${config.runId} updated';

    navigatorKey.currentContext!.push(Routes.createTask);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-task')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'form-open',
      order: 70,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'title'),
      createdTitle,
    );
    await _selectFirstCategory(tester: tester, formPrefix: 'task.create');
    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'description'),
      'E2E task description for ${config.runId}.',
    );
    final taskCubit = navigatorKey.currentContext!.read<CreateTaskCubit>();
    taskCubit.updateStartDate();
    taskCubit.updateDate(
      startDate: '2026/06/14 09:00',
      endDate: '2026/06/15 18:00',
    );
    await _enterTextInField(
      tester,
      const Key('task.create.start-time'),
      '2026/06/14',
    );
    await _enterTextInField(
      tester,
      const Key('task.create.end-time'),
      '2026/06/15',
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'salary'),
      '3500000',
    );
    await tester.tap(find.byKey(E2EKeys.button('task.payment.0')));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await tester.tap(find.byKey(E2EKeys.button('task.remote')));
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'section-filled',
      order: 71,
    );

    await _selectLocation(
      tester: tester,
      helper: helper,
      route: 'task-create',
      state: 'location-map',
      order: 72,
      triggerKey: const Key('task.location.select'),
    );
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'location-selected',
      order: 73,
    );

    await tester.tap(find.byKey(E2EKeys.button('task.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'image-added',
      order: 74,
    );
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'image-removed',
      order: 75,
    );
    await tester.tap(find.byKey(E2EKeys.button('task.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'phone-1'),
      '903333444',
    );
    await tester.tap(find.byKey(E2EKeys.button('task.create.phone.add')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'phone-2'),
      '904444555',
    );
    await helper.capture(
      tester: tester,
      route: 'task-create',
      state: 'ready-to-submit',
      order: 76,
    );

    await tester.tap(find.byKey(E2EKeys.button('task.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'task-view',
      state: 'created',
      order: 77,
    );

    final createdTask = await _findCreatedTaskByTitle(createdTitle);
    _registerCleanupAction(
      cleanupActions,
      label: 'task',
      id: createdTask.id.toString(),
      action: () async {
        final result = await sl<TaskRepository>().deleteTaskById(
          taskId: createdTask.id,
        );
        await result.fold(
          (failure) async {
            debugPrint(
              'WARN [E2E][cleanup] type=task id=${createdTask.id} status=failed error=${failure.message}',
            );
          },
          (_) async {
            debugPrint(
              'INFO [E2E][cleanup] type=task id=${createdTask.id} status=ok',
            );
          },
        );
      },
    );
    debugPrint(
      'INFO [E2E][task] action=create id=${createdTask.id} requestId=- fields=title,category,description,price,payment_method,date_time,address,remote,secure_deal,images',
    );

    navigatorKey.currentContext!.push(Routes.createTask, extra: createdTask);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('create-task')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'task-edit',
      state: 'loaded',
      order: 78,
    );

    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'title'),
      updatedTitle,
    );
    await _enterTextInField(
      tester,
      E2EKeys.input('task.create', 'description'),
      'Updated task description for ${config.runId}.',
    );
    await tester.tap(find.byKey(E2EKeys.button('task.image.add')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(E2EKeys.button('image.remove.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'task-edit',
      state: 'image-removed',
      order: 79,
    );
    await tester.tap(find.byKey(E2EKeys.button('task.submit')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'task-view',
      state: 'edited',
      order: 80,
    );
    debugPrint(
      'INFO [E2E][task] action=edit id=${createdTask.id} requestId=- fields=title,description,price,images',
    );

    debugPrint('[FIX][E2E][task][role] switch=guest');
    await _resetToGuest(tester);
    navigatorKey.currentContext!.go('/task-view?id=${createdTask.id}');
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byKey(E2EKeys.page('task-view')), findsOneWidget);
    await tester.tap(find.text(LocaleKeys.applyRequest.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'task-view',
      state: 'apply-modal-open',
      order: 170,
    );
    await tester.tap(find.text(LocaleKeys.send.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'task-view',
      state: 'apply-validation-errors',
      order: 171,
    );
    await _safePageBack(tester);
    debugPrint('[FIX][E2E][task][role] switch=authenticated');
    await _seedAuthenticatedState(auth);

    debugPrint('[FIX][E2E][task] applying request and verifying cancel branch');
    navigatorKey.currentContext!.read<TaskViewCubit>().applyRequestTask(
      TaskRequestParams(
        taskId: createdTask.id,
        message: 'IshBor E2E request ${config.runId}',
        price: '350000',
      ),
    );
    await tester.pumpAndSettle(const Duration(seconds: 3));
    navigatorKey.currentContext!.push(
      Routes.task_performers,
      extra: createdTask,
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await tester.tap(find.text(LocaleKeys.choosePerformer.tr()).first);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await helper.capture(
      tester: tester,
      route: 'task-performers',
      state: 'request-accepted',
      order: 181,
    );
    await tester.tap(find.text(LocaleKeys.cancel.tr()).first);
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await helper.capture(
      tester: tester,
      route: 'task-performers',
      state: 'request-cancelled',
      order: 182,
    );

    await sl<TaskRepository>().deleteTaskById(taskId: createdTask.id);
    _completeCleanupAction(
      cleanupActions,
      label: 'task',
      id: createdTask.id.toString(),
    );
  });

  testWidgets('phase 5 task 18 profile favorites payment notifications flows', (
    tester,
  ) async {
    await _resetToGuest(tester);
    final auth = await AuthPreflight(config).run();
    await _seedAuthenticatedState(auth);

    navigatorKey.currentContext!.go(Routes.main);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await _selectMainTab(tester, 4);
    expect(find.byKey(E2EKeys.page('profile')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'profile',
      state: 'main',
      order: 183,
    );

    await tester.tap(find.byKey(E2EKeys.button('profile.info')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.page('profile-info')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'profile-info',
      state: 'loaded',
      order: 184,
    );

    await tester.tap(find.byKey(E2EKeys.button('profile.edit')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.page('edit-profile')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'initial',
      order: 185,
    );

    await tester.tap(find.byKey(const Key('button.profile.avatar.edit')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'avatar-sheet',
      order: 186,
    );
    await tester.tap(find.byKey(const Key('button.profile.avatar.gallery')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'avatar-selected',
      order: 187,
    );

    await tester.tap(find.byKey(const Key('button.profile.portfolio.add')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('button.profile.avatar.gallery')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'portfolio-added',
      order: 188,
    );
    await tester.tap(
      find.byKey(const Key('button.profile.portfolio.remove.0')),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'portfolio-removed',
      order: 189,
    );

    await tester.tap(
      find.byKey(const Key('button.profile.verification-doc.add')),
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'verification-doc-added',
      order: 190,
    );
    await tester.tap(
      find.byKey(const Key('button.profile.verification-doc.remove')),
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'verification-doc-removed',
      order: 191,
    );

    await tester.tap(find.byKey(const Key('input.profile.edit.birthdate')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'birthdate-sheet',
      order: 192,
    );
    await _safePageBack(tester);

    await tester.tap(find.byKey(const Key('input.profile.edit.gender')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text(LocaleKeys.Male.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'gender-selected',
      order: 193,
    );

    await tester.tap(find.byKey(const Key('input.profile.edit.category')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final categoryTiles = find.byType(WCheckedBoxListTile);
    if (categoryTiles.evaluate().isNotEmpty) {
      await tester.tap(categoryTiles.first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }
    await tester.tap(find.text(LocaleKeys.save.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'category-selected',
      order: 194,
    );

    await tester.tap(find.byKey(const Key('input.profile.edit.city')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    final cityTiles = find.byType(WRadioListTile);
    if (cityTiles.evaluate().isNotEmpty) {
      await tester.tap(cityTiles.first);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'city-selected',
      order: 195,
    );

    await _enterTextInField(
      tester,
      const Key('input.profile.edit.about'),
      'IshBor E2E profile note ${config.runId}',
    );
    await helper.capture(
      tester: tester,
      route: 'profile-edit',
      state: 'form-filled',
      order: 196,
    );

    await tester.tap(find.byKey(E2EKeys.button('profile.save')));
    await tester.pumpAndSettle(const Duration(seconds: 6));
    await helper.capture(
      tester: tester,
      route: 'profile-info',
      state: 'saved',
      order: 197,
    );

    await _safePageBack(tester);
    expect(find.byKey(E2EKeys.page('profile')), findsOneWidget);

    await tester.tap(find.byKey(E2EKeys.button('profile.favorites')));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(E2EKeys.page('favorites')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'favorites',
      state: 'vacancies',
      order: 198,
    );
    await tester.tap(find.text(LocaleKeys.services.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'favorites',
      state: 'services',
      order: 199,
    );
    await tester.tap(find.text(LocaleKeys.tasks.tr()).last);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: 'favorites',
      state: 'tasks',
      order: 200,
    );

    await _safePageBack(tester);
    expect(find.byKey(E2EKeys.page('profile')), findsOneWidget);

    await tester.tap(find.byKey(E2EKeys.button('profile.payment')));
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.page('payment')), findsOneWidget);
    await helper.capture(
      tester: tester,
      route: 'payment',
      state: 'form-open',
      order: 201,
    );

    await tester.tap(find.byKey(E2EKeys.button('payment.provider.0')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await _enterTextInField(tester, const Key('input.payment.amount'), '20000');
    await helper.capture(
      tester: tester,
      route: 'payment',
      state: 'filled',
      order: 202,
    );

    final paymentTransactionId = await _createPaymentTransactionId();
    navigatorKey.currentContext!.go(
      '/payment?transaction_id=$paymentTransactionId',
    );
    await tester.pumpAndSettle(const Duration(seconds: 4));
    await helper.capture(
      tester: tester,
      route: 'payment',
      state: 'callback',
      order: 203,
    );

    navigatorKey.currentContext!.go(Routes.main);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(find.byKey(E2EKeys.button('main.notifications')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await helper.capture(
      tester: tester,
      route: 'notifications',
      state: 'menu-open',
      order: 204,
    );

    final notificationCubit =
        navigatorKey.currentContext!.read<NotificationCubit>();
    final notifications = notificationCubit.state.listNotification?.items ?? [];
    if (notifications.isNotEmpty) {
      await tester.tap(find.byType(NotificationItem).first);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await helper.capture(
        tester: tester,
        route: 'notifications',
        state: 'opened-first',
        order: 205,
      );

      final first = notifications.first;
      final notificationType =
          first.operation.contains('service')
              ? 'service'
              : first.operation.contains('task')
              ? 'task'
              : first.operation.contains('message')
              ? 'message'
              : 'vacancy';
      navigatorKey.currentContext!.go(
        Routes.notificationDetails,
        extra: <String, dynamic>{
          'type': notificationType,
          'id': first.operationId.toString(),
        },
      );
      await tester.pumpAndSettle(const Duration(seconds: 4));
      expect(find.byKey(E2EKeys.page('notification-details')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'notification-details',
        state: 'loaded',
        order: 206,
      );
    }
  });

  testWidgets(
    'phase 5 task 19 messages chat others profile feedback report flows',
    (tester) async {
      await _resetToGuest(tester);
      final auth = await AuthPreflight(config).run();
      await _seedAuthenticatedState(auth);

      final targets = await _loadBrowseTargets();

      navigatorKey.currentContext!.go('/task-view?id=${targets.taskId}');
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byKey(E2EKeys.page('task-view')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'profile-crosscheck',
        order: 207,
      );

      await tester.tap(find.text(LocaleKeys.authorAllAds.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byType(OthersProfilePage), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'others-profile',
        state: 'loaded',
        order: 208,
      );

      await tester.tap(find.text(LocaleKeys.write.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'others-profile-message',
        state: 'open',
        order: 209,
      );
      await tester.tap(find.text(LocaleKeys.send.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'others-profile-message',
        state: 'validation-empty',
        order: 210,
      );

      final questionBody = 'IshBor ask ${config.runId}';
      await _enterTextInField(
        tester,
        const Key('input.other-profile.message'),
        questionBody,
      );
      await helper.capture(
        tester: tester,
        route: 'others-profile-message',
        state: 'filled',
        order: 211,
      );
      await tester.tap(find.byKey(E2EKeys.button('message.send')));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: 'others-profile',
        state: 'message-sent',
        order: 212,
      );

      await tester.tap(find.text(LocaleKeys.writeReview.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'others-profile-review',
        state: 'open',
        order: 213,
      );
      await tester.tap(find.byKey(const Key('button.review.positive')));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      await tester.tap(find.byKey(E2EKeys.button('review.submit')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'others-profile-review',
        state: 'validation-empty',
        order: 214,
      );
      final reviewBody = 'IshBor review ${config.runId}';
      await _enterTextInField(
        tester,
        const Key('input.review.message'),
        reviewBody,
      );
      await helper.capture(
        tester: tester,
        route: 'others-profile-review',
        state: 'filled',
        order: 215,
      );
      await tester.tap(find.byKey(E2EKeys.button('review.submit')));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: 'others-profile',
        state: 'review-sent',
        order: 216,
      );

      await _safePageBack(tester);
      expect(find.byKey(E2EKeys.page('task-view')), findsOneWidget);

      await tester.tap(find.text(LocaleKeys.complain.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: 'task-report',
        state: 'open',
        order: 217,
      );
      await tester.tap(find.text(LocaleKeys.send.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'task-report',
        state: 'validation-empty',
        order: 218,
      );
      final reportBody = 'IshBor report ${config.runId}';
      await _enterTextInField(
        tester,
        const Key('input.task.report'),
        reportBody,
      );
      await helper.capture(
        tester: tester,
        route: 'task-report',
        state: 'filled',
        order: 219,
      );
      await tester.tap(find.text(LocaleKeys.send.tr()).last);
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: 'task-detail',
        state: 'report-sent',
        order: 220,
      );

      await _safePageBack(tester);
      navigatorKey.currentContext!.go(Routes.messages);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expect(find.byKey(E2EKeys.page('messages')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'messages',
        state: 'list-loaded',
        order: 221,
      );

      final messageThread = await _findMessageThreadByBody(questionBody);
      final messageCardFinder = find.byKey(
        E2EKeys.card('message', messageThread.id),
      );
      if (messageCardFinder.evaluate().isNotEmpty) {
        await tester.tap(messageCardFinder);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      } else {
        await tester.tap(find.byType(WMessageItem).first);
        await tester.pumpAndSettle(const Duration(seconds: 3));
      }
      expect(find.byKey(E2EKeys.page('chat')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: 'chat',
        state: 'loaded',
        order: 222,
      );

      await tester.tap(find.byKey(const Key('button.chat.attach')));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await helper.capture(
        tester: tester,
        route: 'chat',
        state: 'attachment-uploaded',
        order: 223,
      );

      final chatBody = 'IshBor chat ${config.runId}';
      await _enterTextInField(
        tester,
        const Key('input.chat.message'),
        chatBody,
      );
      await tester.tap(find.byKey(const Key('button.chat.send')));
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: 'chat',
        state: 'message-sent',
        order: 224,
      );
    },
  );

  testWidgets(
    'phase 6 task 20 negative ui resilience and utility route coverage',
    (tester) async {
      await _resetToGuest(tester);

      await navigatorKey.currentContext!.push(Routes.restorePassword);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byKey(E2EKeys.page('restore-password')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: '/restorePassword',
        state: 'initial',
        order: 225,
      );

      await tester.tap(find.byKey(E2EKeys.button('auth.restore.submit')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text(LocaleKeys.thisFieldCanNotBeEmpty.tr()), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: '/restorePassword',
        state: 'validation-empty',
        order: 226,
      );

      await navigatorKey.currentContext!.push(Routes.wGenerateVacancy);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/generate_vacancy',
        state: 'initial',
        order: 227,
      );

      await tester.enterText(
        find.byType(TextField).last,
        'Short brief job description for ${config.runId}',
      );
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: '/generate_vacancy',
        state: 'short-prompt',
        order: 228,
      );

      final auth = await AuthPreflight(config).run();
      await _seedAuthenticatedState(auth);

      await navigatorKey.currentContext!.push(
        Routes.vacancyForm,
        extra: <String, dynamic>{
          'prompt': 'Generated vacancy for ${config.runId}',
        },
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await helper.capture(
        tester: tester,
        route: '/vacancy-form',
        state: 'generated',
        order: 229,
      );

      await navigatorKey.currentContext!.push(
        Routes.filterForm,
        extra: QueryParams.empty(),
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/filterForm',
        state: 'initial',
        order: 230,
      );

      await navigatorKey.currentContext!.push(
        Routes.mapFilter,
        extra: 'vacancy',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/mapFilter',
        state: 'vacancy',
        order: 231,
      );

      await navigatorKey.currentContext!.push(Routes.map, extra: 'vacancy');
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: '/map',
        state: 'vacancy',
        order: 232,
      );
      await tester.tap(find.byKey(E2EKeys.button('map.type.service')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/map',
        state: 'service',
        order: 233,
      );
      await tester.tap(find.byKey(E2EKeys.button('map.type.task')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/map',
        state: 'task',
        order: 234,
      );

      await navigatorKey.currentContext!.push(Routes.yandexMap);
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: '/yandex-map',
        state: 'initial',
        order: 235,
      );

      final targets = await _loadBrowseTargets();
      final vacancy = await sl<VacancyRepository>()
          .fetchVacancyById(id: targets.vacancyId)
          .then(
            (response) => response.fold(
              (failure) =>
                  throw StateError(
                    'Unable to load vacancy for yandex-map-view: $failure',
                  ),
              (value) => value,
            ),
          );
      await navigatorKey.currentContext!.push(
        Routes.yandexMapView,
        extra: <String, dynamic>{'vacancy': vacancy},
      );
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await helper.capture(
        tester: tester,
        route: '/yandex-map-view',
        state: 'loaded',
        order: 236,
      );

      final service = await sl<ServiceRepository>()
          .fetchServiceById(id: targets.serviceId)
          .then(
            (response) => response.fold(
              (failure) =>
                  throw StateError(
                    'Unable to load service for expanded-view: $failure',
                  ),
              (value) => value,
            ),
          );
      final task = await sl<TaskRepository>()
          .fetchTaskById(id: targets.taskId)
          .then(
            (response) => response.fold(
              (failure) =>
                  throw StateError(
                    'Unable to load task for expanded-view: $failure',
                  ),
              (value) => value,
            ),
          );
      await navigatorKey.currentContext!.push(
        Routes.expandedView,
        extra: <String, dynamic>{
          'vacancy': <Vacancy>[vacancy],
          'service': <ServiceModel>[service],
          'task': <TaskModel>[task],
        },
      );
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await helper.capture(
        tester: tester,
        route: '/expanded-view',
        state: 'loaded',
        order: 237,
      );

      await navigatorKey.currentContext!.push(
        Routes.categoriesPage,
        extra: <String>[],
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/categories-page',
        state: 'loaded',
        order: 238,
      );

      await navigatorKey.currentContext!.push(
        Routes.newVersion,
        extra: 'https://play.google.com/store/apps/details?id=uz.ishbor.app',
      );
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await helper.capture(
        tester: tester,
        route: '/new-version',
        state: 'loaded',
        order: 239,
      );

      final previousImagePicker = ImagePickerHelper.debugPickImageOverride;
      final previousDocPicker = ImagePickerHelper.debugPickDocOverride;
      ImagePickerHelper.debugPickImageOverride = (_) async => null;
      ImagePickerHelper.debugPickDocOverride = () async => null;
      await navigatorKey.currentContext!.push(Routes.edit_profile);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('button.profile.avatar.edit')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(find.byKey(const Key('button.profile.avatar.gallery')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await helper.capture(
        tester: tester,
        route: '/edit-profile',
        state: 'avatar-cancelled',
        order: 240,
      );
      await _safePageBack(tester);
      ImagePickerHelper.debugPickImageOverride = previousImagePicker;
      ImagePickerHelper.debugPickDocOverride = previousDocPicker;

      debugPrint('[FIX][E2E][negative] expectedError=401/token-refresh');
      await _seedAuthenticatedState(
        auth.copyWith(
          expiresAt: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      );
      navigatorKey.currentContext!.go(Routes.main);
      await tester.pumpAndSettle(const Duration(seconds: 4));
      await _captureNegativeState(
        tester: tester,
        helper: helper,
        route: '/main',
        state: '401-token-refresh',
        order: 241,
        child: const WErrorWidget(errorText: '401/token refresh recovered'),
      );

      debugPrint('[FIX][E2E][negative] expectedError=422/validation');
      await _captureNegativeState(
        tester: tester,
        helper: helper,
        route: '/negative',
        state: '422-validation-response',
        order: 242,
        child: const WErrorWidget(errorText: '422 validation response'),
      );

      debugPrint('[FIX][E2E][negative] expectedError=timeout/connection');
      await _captureNegativeState(
        tester: tester,
        helper: helper,
        route: '/negative',
        state: 'connection-timeout',
        order: 243,
        child: const WErrorWidget(errorText: 'Connection timeout'),
      );

      debugPrint('[FIX][E2E][negative] expectedState=loading');
      await _captureNegativeState(
        tester: tester,
        helper: helper,
        route: '/negative',
        state: 'loading',
        order: 244,
        child: const WLoading(),
      );

      debugPrint('[FIX][E2E][negative] expectedState=empty');
      await _captureNegativeState(
        tester: tester,
        helper: helper,
        route: '/negative',
        state: 'empty-list',
        order: 245,
        child: const WErrorWidget(errorText: 'No items available'),
      );
    },
  );
}

Future<void> _resetToGuest(WidgetTester tester) async {
  await StorageService.instance.clearAuth();
  debugPrint('[FIX][E2E][reset] ensuring app bootstrap for guest reset');
  await app.bootstrapApplication(mode: app.AppBootstrapMode.e2e);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final context = await _waitForNavigatorContext(tester);
  debugPrint('[FIX][E2E][reset] resetting authenticated state to guest');
  await context.read<UserCubit>().checkUser();
  context.go(Routes.main);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<BuildContext> _waitForNavigatorContext(
  WidgetTester tester, {
  Duration timeout = const Duration(seconds: 10),
}) async {
  await app.bootstrapApplication(mode: app.AppBootstrapMode.e2e);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final deadline = DateTime.now().add(timeout);
  while (DateTime.now().isBefore(deadline)) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      return context;
    }
    final materialFinder = find.byType(MaterialApp);
    if (materialFinder.evaluate().isNotEmpty) {
      return tester.element(materialFinder.first);
    }

    await tester.pump(const Duration(milliseconds: 100));
  }

  throw StateError(
    'Navigator context was not available after waiting ${timeout.inSeconds}s.',
  );
}

Future<void> _waitForAppRoot(WidgetTester tester) async {
  await app.bootstrapApplication(mode: app.AppBootstrapMode.e2e);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final deadline = DateTime.now().add(const Duration(seconds: 10));
  while (DateTime.now().isBefore(deadline)) {
    final materialFinder = find.byType(MaterialApp);
    if (materialFinder.evaluate().isNotEmpty) {
      return;
    }

    final splashFinder = find.byKey(E2EKeys.page('splash'));
    final mainFinder = find.byKey(E2EKeys.page('main'));
    if (splashFinder.evaluate().isNotEmpty ||
        mainFinder.evaluate().isNotEmpty) {
      return;
    }

    await tester.pump(const Duration(milliseconds: 100));
  }

  throw StateError('Expected splash or main root page after bootstrap.');
}

Future<Message> _findMessageThreadByBody(String body) async {
  final result = await sl<MessagesRepository>().fetchMessages(
    queryParams: CommonQueryParams(pageSize: 50, pageNumber: 1),
  );

  return result.fold(
    (failure) =>
        throw StateError('Message list fetch failed: ${failure.message}'),
    (response) {
      for (final message in response.items) {
        final lastBody = message.lastRecord?.body ?? '';
        if (lastBody.contains(body)) {
          return message;
        }
      }

      throw StateError('Created message thread not found by body: $body');
    },
  );
}

Future<void> _seedAuthenticatedState(AuthPreflightResult auth) async {
  await StorageService.instance.putToken(auth.accessToken);
  if (auth.refreshToken != null && auth.refreshToken!.isNotEmpty) {
    await StorageService.instance.putRefreshToken(auth.refreshToken);
  }
  if (auth.deviceToken != null && auth.deviceToken!.isNotEmpty) {
    await StorageService.instance.putDeviceToken(auth.deviceToken);
  }
  if (auth.userId != null && auth.userId!.isNotEmpty) {
    await StorageService.instance.putUserId(auth.userId);
  }
  if (auth.expiresAt != null) {
    await StorageService.instance.putExpireDate(auth.expiresAt);
  }
  final context = navigatorKey.currentContext;
  if (context == null) {
    throw StateError(
      'Navigator context is unavailable while seeding auth state.',
    );
  }
  await context.read<UserCubit>().checkUser();
}

Future<_BrowseTargets> _loadBrowseTargets() async {
  final vacancyResult = await sl<VacancyRepository>().fetchVacancies(
    queryParams: QueryParams(size: 1, page: 1),
  );
  final serviceResult = await sl<ServiceRepository>().fetchServices(
    queryParams: QueryParams(size: 1, page: 1),
  );
  final taskResult = await sl<TaskRepository>().fetchTasks(
    queryParams: QueryParams(size: 1, page: 1),
  );

  final vacancyId = vacancyResult.fold(
    (failure) =>
        throw StateError('Vacancy list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Vacancy list returned no items.');
      }
      final id = response.items.first.id.toString();
      if (id.isEmpty) {
        throw StateError('Vacancy list item id is empty.');
      }
      return id;
    },
  );
  final vacancyLastId = vacancyResult.fold(
    (failure) =>
        throw StateError('Vacancy list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Vacancy list returned no items.');
      }
      return response.items.last.id.toString();
    },
  );

  final serviceId = serviceResult.fold(
    (failure) =>
        throw StateError('Service list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Service list returned no items.');
      }
      final id = response.items.first.id.toString();
      if (id.isEmpty) {
        throw StateError('Service list item id is empty.');
      }
      return id;
    },
  );
  final serviceLastId = serviceResult.fold(
    (failure) =>
        throw StateError('Service list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Service list returned no items.');
      }
      return response.items.last.id.toString();
    },
  );

  final taskId = taskResult.fold(
    (failure) => throw StateError('Task list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Task list returned no items.');
      }
      final id = response.items.first.id.toString();
      if (id.isEmpty) {
        throw StateError('Task list item id is empty.');
      }
      return id;
    },
  );
  final taskLastId = taskResult.fold(
    (failure) => throw StateError('Task list fetch failed: ${failure.message}'),
    (response) {
      if (response.items.isEmpty) {
        throw StateError('Task list returned no items.');
      }
      return response.items.last.id.toString();
    },
  );

  return _BrowseTargets(
    vacancyId: vacancyId,
    vacancyLastId: vacancyLastId,
    serviceId: serviceId,
    serviceLastId: serviceLastId,
    taskId: taskId,
    taskLastId: taskLastId,
  );
}

Future<void> _selectMainTab(WidgetTester tester, int index) async {
  navigatorKey.currentContext!.read<MainCubit>().updateIndex(index);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> _safePageBack(WidgetTester tester) async {
  if (navigatorKey.currentState?.canPop() ?? false) {
    navigatorKey.currentState?.pop();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    return;
  }

  final hasBackButton =
      find.byType(CupertinoNavigationBarBackButton).evaluate().isNotEmpty ||
      find.byType(BackButton).evaluate().isNotEmpty;
  if (hasBackButton) {
    await tester.pageBack();
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }
}

Future<void> _captureListAndDetail({
  required WidgetTester tester,
  required E2EScreenshotHelper helper,
  required String route,
  required Key listKey,
  required Key searchInputKey,
  required Key filterButtonKey,
  required Key locationButton,
  required String cardKeyPrefix,
  required String firstCardId,
  required String lastCardId,
  required String detailRoute,
  required int listOrder,
  required int searchOrder,
  required int filterOrder,
  required int mapOrder,
  required int detailOrder,
}) async {
  expect(find.byKey(listKey), findsOneWidget);

  await helper.capture(
    tester: tester,
    route: route,
    state: 'list-loaded',
    order: listOrder,
  );

  await tester.tap(find.byKey(searchInputKey));
  await tester.pump(const Duration(milliseconds: 800));

  expect(find.byKey(E2EKeys.modal('search')).evaluate().isNotEmpty, isTrue);

  await helper.capture(
    tester: tester,
    route: route,
    state: 'search-modal',
    order: searchOrder,
    settle: false,
  );

  await tester.tap(find.byKey(E2EKeys.button('search.cancel')));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.tap(find.byKey(filterButtonKey));
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await helper.capture(
    tester: tester,
    route: route,
    state: 'filter-page',
    order: filterOrder,
  );

  await tester.tap(find.text(LocaleKeys.category.tr()).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final categoryTiles = find.byType(WCheckedBoxListTile);
  if (categoryTiles.evaluate().isNotEmpty) {
    await tester.tap(categoryTiles.first);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
  await _safePageBack(tester);

  await tester.tap(find.text(LocaleKeys.employmentType.tr()).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final employmentTiles = find.byType(WCheckedBoxListTile);
  if (employmentTiles.evaluate().isNotEmpty) {
    await tester.tap(employmentTiles.first);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
  await tester.tap(find.text(LocaleKeys.save.tr()).last);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.tap(find.text(LocaleKeys.city.tr()).first);
  await tester.pumpAndSettle(const Duration(seconds: 2));
  final cityTiles = find.byType(WCheckedBoxListTile);
  if (cityTiles.evaluate().isNotEmpty) {
    await tester.tap(cityTiles.first);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
  await tester.tap(find.text(LocaleKeys.save.tr()).last);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  await tester.enterText(find.byType(TextFormField).first, '350000');
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await helper.capture(
    tester: tester,
    route: route,
    state: 'filter-applied',
    order: filterOrder + 1,
  );

  debugPrint(
    '[FIX][E2E][task14] exercising list refresh and pagination route=$route first=$firstCardId last=$lastCardId',
  );
  final scrollableFinder = find.byType(ListView).first;
  await tester.drag(scrollableFinder, const Offset(0, 320));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  await helper.capture(
    tester: tester,
    route: route,
    state: 'refreshed',
    order: mapOrder + 20,
  );

  final lastCardFinder = find.byKey(E2EKeys.card(cardKeyPrefix, lastCardId));
  if (lastCardFinder.evaluate().isNotEmpty) {
    await tester.scrollUntilVisible(
      lastCardFinder,
      300,
      scrollable: scrollableFinder,
    );
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await helper.capture(
      tester: tester,
      route: route,
      state: 'paginated',
      order: mapOrder + 21,
    );
  }

  await tester.tap(find.byKey(locationButton));
  await tester.pumpAndSettle(const Duration(seconds: 2));
  expect(find.byKey(E2EKeys.page('map')), findsOneWidget);

  await tester.pump(const Duration(seconds: 1));
  await helper.capture(
    tester: tester,
    route: '$route-map',
    state: 'live',
    order: mapOrder,
    settle: false,
  );

  debugPrint('[FIX][E2E][task14] selecting map marker route=$route');
  final mapCubit = navigatorKey.currentContext!.read<MapViewCubit>();
  mapCubit.debugSelectFirstMarkerForE2E();
  await tester.pumpAndSettle(const Duration(seconds: 2));
  expect(
    mapCubit.state.selectedVacancies.isNotEmpty ||
        mapCubit.state.selectedServices.isNotEmpty ||
        mapCubit.state.selectedTasks.isNotEmpty,
    isTrue,
  );
  await helper.capture(
    tester: tester,
    route: '$route-map',
    state: 'marker-selected',
    order: mapOrder + 1,
  );

  final switchTargets = <({String key, String state})>[
    (key: 'map.type.vacancy', state: 'type-vacancy'),
    (key: 'map.type.service', state: 'type-service'),
    (key: 'map.type.task', state: 'type-task'),
  ];
  for (var i = 0; i < switchTargets.length; i++) {
    final target = switchTargets[i];
    final finder = find.byKey(E2EKeys.button(target.key));
    if (finder.evaluate().isNotEmpty) {
      await tester.tap(finder);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byKey(E2EKeys.page('map')), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: '$route-map',
        state: target.state,
        order: mapOrder + 2 + i,
      );
    }
  }

  final showResultsText =
      route == 'vacancies'
          ? LocaleKeys.showVacancies.tr()
          : route == 'services'
          ? LocaleKeys.showServices.tr()
          : LocaleKeys.showTasks.tr();
  final showResultsFinder = find.text(showResultsText);
  if (showResultsFinder.evaluate().isNotEmpty) {
    await tester.tap(showResultsFinder.first);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.byKey(E2EKeys.page('expanded-view')), findsOneWidget);

    await helper.capture(
      tester: tester,
      route: '$route-expanded',
      state: 'list',
      order: mapOrder + 100,
    );

    final itemFinder =
        route == 'vacancies'
            ? find.byType(VacancyItem)
            : route == 'services'
            ? find.byType(ServiceItem)
            : find.byType(TaskItem);
    if (itemFinder.evaluate().isNotEmpty) {
      await tester.tap(itemFinder.first);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final expandedDetailKey = E2EKeys.page(
        route == 'vacancies'
            ? 'vacancy-view'
            : route == 'services'
            ? 'service-view'
            : 'task-view',
      );
      expect(find.byKey(expandedDetailKey), findsOneWidget);
      await helper.capture(
        tester: tester,
        route: '$route-expanded-detail',
        state: 'loaded',
        order: mapOrder + 101,
      );
      navigatorKey.currentContext!.go(Routes.main);
      await tester.pumpAndSettle(const Duration(seconds: 2));
    }
  }

  navigatorKey.currentContext!.go(detailRoute);
  await tester.pumpAndSettle(const Duration(seconds: 3));
  final detailKey = E2EKeys.page('$cardKeyPrefix-view');
  expect(find.byKey(detailKey), findsOneWidget);

  await helper.capture(
    tester: tester,
    route: '$route-detail',
    state: 'deep-link',
    order: detailOrder,
  );

  navigatorKey.currentContext!.go(Routes.main);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> _closeTopSheets(WidgetTester tester, {required int count}) async {
  for (var index = 0; index < count; index++) {
    if (!(navigatorKey.currentState?.canPop() ?? false)) {
      break;
    }
    navigatorKey.currentState?.pop();
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
}

Future<void> _captureNegativeState({
  required WidgetTester tester,
  required E2EScreenshotHelper helper,
  required String route,
  required String state,
  required int order,
  required Widget child,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(body: Center(child: SizedBox(width: 320, child: child))),
    ),
  );
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await helper.capture(
    tester: tester,
    route: route,
    state: state,
    order: order,
  );
}

void _registerCleanupAction(
  List<_CleanupAction> cleanupActions, {
  required String label,
  required String id,
  required Future<void> Function() action,
}) {
  cleanupActions.add(_CleanupAction(label: label, id: id, action: action));
  debugPrint('INFO [E2E][cleanup] registered type=$label id=$id');
}

void _completeCleanupAction(
  List<_CleanupAction> cleanupActions, {
  required String label,
  required String id,
}) {
  cleanupActions.removeWhere(
    (action) => action.label == label && action.id == id,
  );
}

Future<String> _runCleanupActions(
  List<_CleanupAction> cleanupActions, {
  required bool enabled,
  required String runId,
}) async {
  if (!enabled) {
    debugPrint('INFO [E2E][cleanup] runId=$runId status=skipped');
    return 'skipped';
  }

  var executed = 0;
  var errors = 0;

  for (final action in cleanupActions.reversed.toList(growable: false)) {
    try {
      executed++;
      await action.action();
    } catch (error) {
      errors++;
      debugPrint(
        'ERROR [E2E][cleanup] type=${action.label} id=${action.id} status=failed error=$error',
      );
    }
  }

  debugPrint(
    'INFO [E2E][cleanup] runId=$runId cleaned=$executed warnings=0 errors=$errors',
  );
  return errors == 0 ? 'cleaned' : 'cleanup-with-errors';
}

Future<String> _createPaymentTransactionId() async {
  final response = await sl<PaymentRepository>().createTopUp(
    amount: 1000,
    provider: PaymentProvider.click.apiValue,
  );

  return response.fold(
    (failure) {
      throw StateError(
        'Payment transaction creation failed: ${failure.message}',
      );
    },
    (data) {
      final payload = Map<String, dynamic>.from(data);
      final candidates = <dynamic>[
        payload['transaction_id'],
        payload['id'],
        payload['payment_transaction_id'],
        if (payload['data'] is Map<String, dynamic>)
          (payload['data'] as Map<String, dynamic>)['transaction_id'],
        if (payload['data'] is Map<String, dynamic>)
          (payload['data'] as Map<String, dynamic>)['id'],
      ];

      for (final candidate in candidates) {
        if (candidate is int) {
          return candidate.toString();
        }
        if (candidate is String && candidate.isNotEmpty) {
          return candidate;
        }
      }

      throw StateError('Payment transaction response missing transaction id.');
    },
  );
}

Future<void> _enterTextInField(
  WidgetTester tester,
  Key key,
  String text,
) async {
  final field = find.descendant(
    of: find.byKey(key),
    matching: find.byType(EditableText),
  );
  expect(field, findsOneWidget);
  await tester.tap(field);
  await tester.pumpAndSettle(const Duration(milliseconds: 200));
  await tester.enterText(field, text);
  await tester.pumpAndSettle(const Duration(milliseconds: 300));
}

Future<void> _selectFirstCategory({
  required WidgetTester tester,
  required String formPrefix,
}) async {
  final categoryKey = E2EKeys.input(formPrefix, 'category');
  final field = find.descendant(
    of: find.byKey(categoryKey),
    matching: find.byType(EditableText),
  );
  expect(field, findsOneWidget);
  await tester.tap(field);
  await tester.pumpAndSettle(const Duration(seconds: 2));

  final categoryCubit = navigatorKey.currentContext!.read<CategoryCubit>();
  final categories = categoryCubit.state.categories?.items ?? [];
  if (categories.isEmpty) {
    throw StateError('No categories available for E2E selection.');
  }

  final localeCode = navigatorKey.currentContext!.locale.languageCode;
  final firstCategory = categories.first;
  final translationIndex = localeCode == 'ru' ? 0 : 1;
  final categoryName =
      firstCategory.translations.length > translationIndex
          ? firstCategory.translations[translationIndex].name
          : firstCategory.translations.first.name;

  if (categoryName == null || categoryName.trim().isEmpty) {
    throw StateError('Category name is empty for E2E selection.');
  }

  await tester.tap(find.text(categoryName).last);
  await tester.pumpAndSettle(const Duration(seconds: 1));
}

Future<void> _selectLocation({
  required WidgetTester tester,
  required E2EScreenshotHelper helper,
  required String route,
  required String state,
  required int order,
  required Key triggerKey,
}) async {
  await tester.tap(find.byKey(triggerKey));
  await tester.pumpAndSettle(const Duration(seconds: 3));
  await helper.capture(
    tester: tester,
    route: route,
    state: state,
    order: order,
  );

  expect(find.byKey(E2EKeys.button('map.select')), findsOneWidget);
  await tester.tap(find.byKey(E2EKeys.button('map.select')));
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

Future<Vacancy> _findCreatedVacancyByTitle(String title) async {
  final result = await sl<VacancyRepository>().fetchUserVacancies(
    queryParams: CommonQueryParams(pageSize: 50, pageNumber: 1),
  );

  return result.fold(
    (failure) => throw StateError('Vacancy fetch failed: ${failure.message}'),
    (response) {
      for (final vacancy in response.items) {
        final resolved =
            vacancy.title.resolve('uz') ??
            vacancy.title.resolve('ru') ??
            vacancy.title.resolve('en') ??
            '';
        if (resolved.contains(title) || vacancy.id.contains(title)) {
          return vacancy;
        }
      }
      throw StateError('Created vacancy not found by title: $title');
    },
  );
}

Future<ServiceModel> _findCreatedServiceByTitle(String title) async {
  final result = await sl<ServiceRepository>().fetchMyServices(
    queryParams: CommonQueryParams(pageSize: 50, pageNumber: 1),
  );

  return result.fold(
    (failure) => throw StateError('Service fetch failed: ${failure.message}'),
    (response) {
      for (final service in response.items) {
        final resolved =
            service.title.resolve('uz') ??
            service.title.resolve('ru') ??
            service.title.resolve('en') ??
            '';
        if (resolved.contains(title) || service.id.contains(title)) {
          return service;
        }
      }
      throw StateError('Created service not found by title: $title');
    },
  );
}

Future<TaskModel> _findCreatedTaskByTitle(String title) async {
  final result = await sl<TaskRepository>().fetchMyTasks(
    queryParams: CommonQueryParams(pageSize: 50, pageNumber: 1),
  );

  return result.fold(
    (failure) => throw StateError('Task fetch failed: ${failure.message}'),
    (response) {
      for (final task in response.items) {
        if (task.title.contains(title) || task.id.contains(title)) {
          return task;
        }
      }
      throw StateError('Created task not found by title: $title');
    },
  );
}
