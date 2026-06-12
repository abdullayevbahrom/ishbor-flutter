import 'package:flutter/foundation.dart';

final class E2EMatrixSurface {
  const E2EMatrixSurface({
    required this.route,
    required this.cases,
  });

  final String route;
  final int cases;
}

final class E2EMatrixLogger {
  const E2EMatrixLogger._();

  static const List<E2EMatrixSurface> surfaces = <E2EMatrixSurface>[
    E2EMatrixSurface(route: '/splash', cases: 3),
    E2EMatrixSurface(route: '/splash/:payload', cases: 2),
    E2EMatrixSurface(route: '/main', cases: 4),
    E2EMatrixSurface(route: '/main/:payload', cases: 2),
    E2EMatrixSurface(route: '/payment', cases: 3),
    E2EMatrixSurface(route: '/register', cases: 3),
    E2EMatrixSurface(route: '/auth-flow', cases: 5),
    E2EMatrixSurface(route: '/restorePassword', cases: 1),
    E2EMatrixSurface(route: 'VacanciesPage', cases: 3),
    E2EMatrixSurface(route: 'ServicesPage', cases: 3),
    E2EMatrixSurface(route: 'TasksPage', cases: 3),
    E2EMatrixSurface(route: 'MessagesPage', cases: 2),
    E2EMatrixSurface(route: 'ProfilePage', cases: 2),
    E2EMatrixSurface(route: '/vacancy-view', cases: 3),
    E2EMatrixSurface(route: '/service-view', cases: 3),
    E2EMatrixSurface(route: '/task-view', cases: 3),
    E2EMatrixSurface(route: '/createVacancy', cases: 3),
    E2EMatrixSurface(route: '/vacancy-form', cases: 2),
    E2EMatrixSurface(route: '/generate_vacancy', cases: 1),
    E2EMatrixSurface(route: '/createService', cases: 3),
    E2EMatrixSurface(route: '/createTask', cases: 3),
    E2EMatrixSurface(route: '/edit-profile', cases: 3),
    E2EMatrixSurface(route: '/my-favorites', cases: 3),
    E2EMatrixSurface(route: '/notificationDetails', cases: 1),
    E2EMatrixSurface(route: '/task-performers', cases: 1),
    E2EMatrixSurface(route: '/new-version', cases: 1),
    E2EMatrixSurface(route: '/filterForm', cases: 1),
    E2EMatrixSurface(route: '/map', cases: 1),
    E2EMatrixSurface(route: '/mapFilter', cases: 1),
    E2EMatrixSurface(route: '/yandex-map', cases: 1),
    E2EMatrixSurface(route: '/yandex-map-view', cases: 1),
    E2EMatrixSurface(route: '/expanded-view', cases: 1),
    E2EMatrixSurface(route: '/chat', cases: 1),
    E2EMatrixSurface(route: '/othersProfile', cases: 1),
    E2EMatrixSurface(route: '/categories-page', cases: 1),
  ];

  static void emit() {
    final seen = <String>{};
    var totalCases = 0;

    debugPrint(
      '[FIX][E2E][matrix] emitting route inventory count=${surfaces.length}',
    );

    for (final surface in surfaces) {
      if (surface.route.trim().isEmpty) {
        throw StateError('E2E matrix route is empty');
      }
      if (surface.cases <= 0) {
        throw StateError('E2E matrix cases must be positive: ${surface.route}');
      }
      if (!seen.add(surface.route)) {
        throw StateError('Duplicate E2E matrix route: ${surface.route}');
      }

      totalCases += surface.cases;
      debugPrint(
        'DEBUG [E2E][matrix] route=${surface.route} cases=${surface.cases}',
      );
    }

    debugPrint(
      'DEBUG [E2E][matrix] route_count=${surfaces.length} cases=$totalCases',
    );
    debugPrint(
      '[FIX][E2E][matrix] emitted route inventory count=${surfaces.length} cases=$totalCases',
    );
  }
}
