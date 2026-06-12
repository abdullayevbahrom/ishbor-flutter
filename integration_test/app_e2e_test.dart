import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/main/presentation/cubit/main_cubit/main_cubit.dart';
import 'package:top_jobs/feature/map/presentation/cubits/map_view_cubit/map_view_cubit.dart';
import 'package:top_jobs/feature/profile/data/model/payment_provider.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';
import 'package:top_jobs/feature/services/domain/repository/service_repository.dart';
import 'package:top_jobs/feature/tasks/domain/repository/task_repository.dart';
import 'package:top_jobs/feature/vacancies/data/models/vacancy_query_params.dart';
import 'package:top_jobs/feature/vacancies/domain/repository/vacancy_repository.dart';
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

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final config = E2EConfig.fromEnvironment();
  final deviceSetup = E2EDeviceSetup.fromEnvironment();
  final apiCalls = <Map<String, dynamic>>[];
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
    await Future<void>.delayed(const Duration(seconds: 2));
  });

  tearDownAll(() async {
    DioInterceptors.e2eObserver = null;
    await helper.finalize(status: 'passed');
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

    await tester.pumpAndSettle(const Duration(seconds: 3));

    expect(find.byKey(E2EKeys.page('main')), findsOneWidget);

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

    final uiPhone = config.testPhone.replaceFirst(RegExp(r'^\+998'), '');
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
}

Future<void> _resetToGuest(WidgetTester tester) async {
  await StorageService.instance.clearAuth();
  await navigatorKey.currentContext!.read<UserCubit>().checkUser();
  navigatorKey.currentContext!.go(Routes.main);
  await tester.pumpAndSettle(const Duration(seconds: 2));
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
  await navigatorKey.currentContext!.read<UserCubit>().checkUser();
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
  await tester.pageBack();
  await tester.pumpAndSettle(const Duration(seconds: 2));

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
