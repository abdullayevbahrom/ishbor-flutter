import 'package:flutter/foundation.dart';

enum E2ECleanupImpact { warning, error }

typedef E2ECleanupAction = Future<void> Function();

final class E2ETestDataRecord {
  const E2ETestDataRecord({
    required this.type,
    required this.id,
    required this.impact,
    this.cleanup,
    this.metadata = const <String, dynamic>{},
  });

  final String type;
  final String id;
  final E2ECleanupImpact impact;
  final E2ECleanupAction? cleanup;
  final Map<String, dynamic> metadata;
}

final class E2ECleanupSummary {
  const E2ECleanupSummary({
    required this.cleaned,
    required this.warningFailures,
    required this.errorFailures,
  });

  final int cleaned;
  final int warningFailures;
  final int errorFailures;

  bool get hasError => errorFailures > 0;

  String get status {
    if (hasError) {
      return 'error';
    }
    if (warningFailures > 0) {
      return 'warn';
    }
    return 'ok';
  }
}

final class E2ETestData {
  E2ETestData({required this.runId});

  final String runId;
  final List<E2ETestDataRecord> _records = [];

  Map<String, dynamic> tagPayload(
    Map<String, dynamic> payload, {
    String? type,
    String? id,
  }) {
    return <String, dynamic>{
      ...payload,
      'e2e_run_id': runId,
      if (type != null) 'e2e_type': type,
      if (id != null) 'e2e_id': id,
    };
  }

  void registerCreated({
    required String type,
    required String id,
    E2ECleanupAction? cleanup,
    E2ECleanupImpact impact = E2ECleanupImpact.warning,
    Map<String, dynamic> metadata = const <String, dynamic>{},
  }) {
    debugPrint('INFO [E2E][data] created type=$type id=$id runId=$runId');
    _records.add(
      E2ETestDataRecord(
        type: type,
        id: id,
        impact: impact,
        cleanup: cleanup,
        metadata: metadata,
      ),
    );
  }

  Future<E2ECleanupSummary> cleanup() async {
    var cleaned = 0;
    var warningFailures = 0;
    var errorFailures = 0;

    for (final record in _records.reversed) {
      final cleanup = record.cleanup;
      if (cleanup == null) {
        debugPrint(
          'INFO [E2E][cleanup] type=${record.type} id=${record.id} status=skipped',
        );
        continue;
      }

      try {
        await cleanup();
        cleaned += 1;
        debugPrint(
          'INFO [E2E][cleanup] type=${record.type} id=${record.id} status=ok',
        );
      } catch (error) {
        if (record.impact == E2ECleanupImpact.error) {
          errorFailures += 1;
          debugPrint(
            'ERROR [E2E][cleanup] type=${record.type} id=${record.id} status=failed error=$error',
          );
        } else {
          warningFailures += 1;
          debugPrint(
            'WARN [E2E][cleanup] type=${record.type} id=${record.id} status=failed error=$error',
          );
        }
      }
    }

    final summary = E2ECleanupSummary(
      cleaned: cleaned,
      warningFailures: warningFailures,
      errorFailures: errorFailures,
    );

    debugPrint(
      'INFO [E2E][cleanup] runId=$runId cleaned=${summary.cleaned} warnings=${summary.warningFailures} errors=${summary.errorFailures}',
    );
    return summary;
  }
}
