import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:top_jobs/core/services/storage_service.dart';

import 'e2e/auth_preflight.dart';
import 'e2e/e2e_config.dart';
import 'e2e/device_setup.dart';
import 'e2e/flows/realtime_flow.dart';
import 'e2e/screenshot_helper.dart';
import 'e2e/ui_matrix.dart';

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
    E2EMatrixLogger.emit();
    debugPrint('INFO [E2E][device] ${deviceSetup.describeForLog()}');
    await helper.prepare();
  });

  tearDownAll(() async {
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

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('E2E bootstrap'),
          ),
        ),
      ),
    );

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

    final results = await RealtimeFlow().run(
      userId: userId,
      dialogId: userId,
    );
    final fallback = results.any((result) => result.fallback);
    final state = fallback ? 'fallback' : 'connected';

    binding.reportData = <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': 'running',
      'device_setup': deviceSetup.toJson(),
      'mercure': results
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
            child: Text(
              'Mercure $state',
              key: ValueKey('mercure-$state'),
            ),
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
}
