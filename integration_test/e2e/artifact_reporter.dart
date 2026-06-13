import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'ui_matrix.dart';

final class E2ECoverageEntry {
  const E2ECoverageEntry({
    required this.route,
    required this.status,
    required this.screenshots,
  });

  final String route;
  final String status;
  final List<String> screenshots;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'route': route,
    'status': status,
    'screenshots': screenshots,
  };
}

final class E2ECoverageResult {
  const E2ECoverageResult({
    required this.coveredCount,
    required this.missingCount,
    required this.totalCount,
    required this.entries,
    required this.failures,
    required this.appVersion,
    required this.runId,
    required this.apiBaseUrl,
    required this.device,
    required this.screenshotCount,
  });

  final int coveredCount;
  final int missingCount;
  final int totalCount;
  final List<E2ECoverageEntry> entries;
  final List<String> failures;
  final String appVersion;
  final String runId;
  final String apiBaseUrl;
  final String device;
  final int screenshotCount;

  bool get hasMissing => missingCount > 0;

  String toMarkdown() {
    final buffer =
        StringBuffer()
          ..writeln('# E2E Coverage Report')
          ..writeln()
          ..writeln('- Run ID: `$runId`')
          ..writeln('- App version: `$appVersion`')
          ..writeln('- API base URL: `$apiBaseUrl`')
          ..writeln('- Device: `$device`')
          ..writeln('- Screenshots: `$screenshotCount`')
          ..writeln('- Covered: `$coveredCount`')
          ..writeln('- Missing: `$missingCount`')
          ..writeln()
          ..writeln('| Route | Status | Screenshots |')
          ..writeln('|---|---|---|');

    for (final entry in entries) {
      buffer.writeln(
        '| `${entry.route}` | ${entry.status} | ${entry.screenshots.join(', ')} |',
      );
    }

    if (failures.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('## Failures')
        ..writeln();
      for (final failure in failures) {
        buffer.writeln('- $failure');
      }
    }

    return buffer.toString();
  }
}

final class E2EArtifactReporter {
  const E2EArtifactReporter._();

  static Future<E2ECoverageResult> generate({
    required Directory outputDir,
    required File manifestFile,
    required String runId,
    required String apiBaseUrl,
    required String appVersion,
    required String device,
    required bool enforceCoverage,
  }) async {
    final manifest = await _readManifest(manifestFile);
    final screenshots = (manifest['screenshots'] as List<dynamic>? ??
            <dynamic>[])
        .whereType<Map>()
        .map(
          (entry) => Map<String, dynamic>.from(entry.cast<String, dynamic>()),
        )
        .toList(growable: false);

    final routes =
        screenshots
            .map((entry) => entry['route']?.toString() ?? '')
            .where((route) => route.isNotEmpty)
            .toSet();

    final entries = <E2ECoverageEntry>[];
    final failures = <String>[];

    for (final surface in E2EMatrixLogger.surfaces) {
      final matching =
          _matchingScreenshotRoutes(surface.route, routes).toList()..sort();
      final covered = matching.isNotEmpty;
      final status = covered ? 'covered' : 'missing';
      if (!covered) {
        failures.add('Missing screenshot coverage for ${surface.route}');
      }
      entries.add(
        E2ECoverageEntry(
          route: surface.route,
          status: status,
          screenshots: matching,
        ),
      );
    }

    final result = E2ECoverageResult(
      coveredCount: entries.where((entry) => entry.status == 'covered').length,
      missingCount: entries.where((entry) => entry.status == 'missing').length,
      totalCount: entries.length,
      entries: entries,
      failures: failures,
      appVersion: appVersion,
      runId: runId,
      apiBaseUrl: apiBaseUrl,
      device: device,
      screenshotCount: screenshots.length,
    );

    final coverageFile = File('${outputDir.path}/coverage.md');
    await coverageFile.writeAsString(result.toMarkdown(), flush: true);

    final failuresFile = File('${outputDir.path}/failures.log');
    await failuresFile.writeAsString(
      result.failures.isEmpty ? 'ok\n' : result.failures.join('\n'),
      flush: true,
    );

    debugPrint(
      'INFO [E2E][coverage] covered=${result.coveredCount} missing=${result.missingCount}',
    );
    debugPrint(
      'INFO [E2E][summary] passed=${result.coveredCount} failed=${result.missingCount} screenshots=${result.screenshotCount} cleanup=${manifest['status'] ?? 'running'}',
    );

    if (enforceCoverage && result.hasMissing) {
      final message = result.failures.join('; ');
      debugPrint('ERROR [E2E][coverage] $message');
      throw StateError(message);
    }

    return result;
  }

  static Future<Map<String, dynamic>> _readManifest(File manifestFile) async {
    if (!await manifestFile.exists()) {
      return <String, dynamic>{
        'run_id': 'unknown',
        'api_base_url': '',
        'app_version': 'unknown',
        'device': 'unknown',
        'status': 'running',
        'screenshots': <dynamic>[],
      };
    }

    final content = await manifestFile.readAsString();
    final decoded = jsonDecode(content);
    if (decoded is Map<String, dynamic>) {
      return Map<String, dynamic>.from(decoded);
    }
    return <String, dynamic>{
      'run_id': 'unknown',
      'api_base_url': '',
      'app_version': 'unknown',
      'device': 'unknown',
      'status': 'running',
      'screenshots': <dynamic>[],
    };
  }

  static Iterable<String> _matchingScreenshotRoutes(
    String surfaceRoute,
    Set<String> routes,
  ) sync* {
    switch (surfaceRoute) {
      case '/splash':
        yield* _firstMatch(routes, <String>{
          'bootstrap',
          'auth-login',
          'auth-otp',
          'auth-register',
          'auth-user-type',
          'auth-name',
          'deep-link-splash',
        });
        break;
      case '/splash/:payload':
        yield* _firstMatch(routes, <String>{'deep-link-splash'});
        break;
      case '/main':
        yield* _firstMatch(routes, <String>{'main-shell', 'main-payload'});
        break;
      case '/main/:payload':
        yield* _firstMatch(routes, <String>{'main-payload'});
        break;
      case '/payment':
        yield* _firstMatch(routes, <String>{'payment'});
        break;
      case '/register':
        yield* _firstMatch(routes, <String>{'auth-register'});
        break;
      case '/auth-flow':
        yield* _firstMatch(routes, <String>{
          'auth-login',
          'auth-otp',
          'auth-user-type',
          'auth-name',
        });
        break;
      case '/restorePassword':
        yield* _firstMatch(routes, <String>{
          'restore-password',
          '/restorePassword',
        });
        break;
      case 'VacanciesPage':
        yield* _firstMatch(routes, <String>{'vacancies'});
        break;
      case 'ServicesPage':
        yield* _firstMatch(routes, <String>{'services'});
        break;
      case 'TasksPage':
        yield* _firstMatch(routes, <String>{'tasks'});
        break;
      case 'MessagesPage':
        yield* _firstMatch(routes, <String>{'messages'});
        break;
      case 'ProfilePage':
        yield* _firstMatch(routes, <String>{'profile'});
        break;
      case '/vacancy-view':
        yield* _firstMatch(routes, <String>{'vacancy-detail', 'vacancy-view'});
        break;
      case '/service-view':
        yield* _firstMatch(routes, <String>{'service-detail', 'service-view'});
        break;
      case '/task-view':
        yield* _firstMatch(routes, <String>{'task-detail', 'task-view'});
        break;
      case '/createVacancy':
        yield* _firstMatch(routes, <String>{
          'vacancy-create',
          '/createVacancy',
        });
        break;
      case '/vacancy-form':
        yield* _firstMatch(routes, <String>{'vacancy-form', '/vacancy-form'});
        break;
      case '/generate_vacancy':
        yield* _firstMatch(routes, <String>{
          'generate-vacancy',
          '/generate_vacancy',
        });
        break;
      case '/createService':
        yield* _firstMatch(routes, <String>{
          'service-create',
          '/createService',
        });
        break;
      case '/createTask':
        yield* _firstMatch(routes, <String>{'task-create', '/createTask'});
        break;
      case '/edit-profile':
        yield* _firstMatch(routes, <String>{'profile-edit', '/edit-profile'});
        break;
      case '/my-favorites':
        yield* _firstMatch(routes, <String>{'favorites', '/my-favorites'});
        break;
      case '/notificationDetails':
        yield* _firstMatch(routes, <String>{
          'notification-details',
          '/notificationDetails',
        });
        break;
      case '/task-performers':
        yield* _firstMatch(routes, <String>{
          'task-performers',
          '/task-performers',
        });
        break;
      case '/new-version':
        yield* _firstMatch(routes, <String>{'new-version', '/new-version'});
        break;
      case '/filterForm':
        yield* _firstMatch(routes, <String>{'filter-form', '/filterForm'});
        break;
      case '/map':
        yield* _firstMatch(routes, <String>{
          'map-vacancy',
          'map-service',
          'map-task',
          'vacancies-map',
          'services-map',
          'tasks-map',
          'map',
          '/map',
        });
        break;
      case '/mapFilter':
        yield* _firstMatch(routes, <String>{'map-filter', '/mapFilter'});
        break;
      case '/yandex-map':
        yield* _firstMatch(routes, <String>{'yandex-map', '/yandex-map'});
        break;
      case '/yandex-map-view':
        yield* _firstMatch(routes, <String>{
          'yandex-map-view',
          '/yandex-map-view',
        });
        break;
      case '/expanded-view':
        yield* _firstMatch(routes, <String>{
          'expanded-view',
          'vacancies-expanded',
          'services-expanded',
          'tasks-expanded',
          '/expanded-view',
        });
        break;
      case '/expanded-detail':
        yield* _firstMatch(routes, <String>{
          'vacancies-expanded-detail',
          'services-expanded-detail',
          'tasks-expanded-detail',
          '/expanded-detail',
        });
        break;
      case '/detail':
        yield* _firstMatch(routes, <String>{
          'vacancies-detail',
          'services-detail',
          'tasks-detail',
          '/detail',
        });
        break;
      case '/chat':
        yield* _firstMatch(routes, <String>{'chat', '/chat'});
        break;
      case '/othersProfile':
        yield* _firstMatch(routes, <String>{
          'others-profile',
          '/othersProfile',
        });
        break;
      case '/categories-page':
        yield* _firstMatch(routes, <String>{
          'categories-page',
          '/categories-page',
        });
        break;
      default:
        yield* _firstMatch(routes, <String>{surfaceRoute});
    }
  }

  static Iterable<String> _firstMatch(
    Set<String> routes,
    Set<String> accepted,
  ) sync* {
    for (final route in accepted) {
      if (routes.contains(route)) {
        yield route;
        return;
      }
    }
  }
}
