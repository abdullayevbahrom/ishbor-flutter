import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:top_jobs/core/constants/api_const.dart';

void main() {
  test('core api constants stay on /api/v1', () {
    final guardedRoutes = <String>[
      ApiConstants.authRequestCode,
      ApiConstants.authVerifyCode,
      ApiConstants.authRegister,
      ApiConstants.authRefresh,
      ApiConstants.authLogout,
      ApiConstants.contentContactClick,
      ApiConstants.notifications,
      ApiConstants.categories,
      ApiConstants.cities,
      ApiConstants.messages,
      ApiConstants.paymentTransactions,
      ApiConstants.reports,
      ApiConstants.search,
      ApiConstants.chatGpt,
      ApiConstants.chatGptDescription,
    ];

    for (final route in guardedRoutes) {
      expect(
        route.startsWith('/api/v1/'),
        isTrue,
        reason: 'Offending route: $route',
      );
    }
  });

  test(
    'datasource sources do not contain legacy or prefixless ishbor paths',
    () {
      final offenders = _findOffendingPaths();
      expect(
        offenders,
        isEmpty,
        reason: offenders.isEmpty ? null : offenders.join('\n'),
      );
    },
  );
}

List<String> _findOffendingPaths() {
  const allowedExternalPrefixes = <String>[
    'https://api.ipify.org',
    'https://api.mapbox.com',
    'https://nominatim.openstreetmap.org',
    'https://tile.openstreetmap.org',
    'https://wss',
    'wss://',
    'https://',
    'http://',
  ];

  const forbiddenLiterals = <String>[
    'security/',
    '/contact-click',
    'me/vacancy/favorites',
    'https://api.ishbor.uz',
    'https://topjob.uz',
    'topjob.uz',
  ];

  final roots = <Directory>[
    Directory('lib/core/network'),
    Directory('lib/feature'),
  ];

  final offenders = <String>[];
  final requestCallPattern = RegExp(
    r'''(?:_dio|dio)\.(get|post|patch|put|delete|getUri|postUri|patchUri|deleteUri|request)\(\s*(['"])(.*?)\2''',
  );

  for (final root in roots) {
    if (!root.existsSync()) {
      continue;
    }

    for (final entity in root
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))) {
      final lines = entity.readAsLinesSync();
      for (var index = 0; index < lines.length; index++) {
        final line = lines[index].trimLeft();
        if (line.startsWith('//')) {
          continue;
        }

        for (final forbidden in forbiddenLiterals) {
          if (line.contains(forbidden)) {
            offenders.add('${entity.path}:${index + 1}: $forbidden');
          }
        }

        final match = requestCallPattern.firstMatch(line);
        if (match == null) {
          continue;
        }

        final literal = match.group(3)!;
        if (literal.startsWith('/api/v1/')) {
          continue;
        }

        if (allowedExternalPrefixes.any(literal.startsWith)) {
          continue;
        }

        offenders.add('${entity.path}:${index + 1}: $literal');
      }
    }
  }

  return offenders;
}
