import 'package:flutter/foundation.dart';
import 'package:top_jobs/core/services/mercure_client.dart';

final class MercureProbeResult {
  const MercureProbeResult({
    required this.label,
    required this.topics,
    required this.connected,
    required this.fallback,
    this.error,
  });

  final String label;
  final List<String> topics;
  final bool connected;
  final bool fallback;
  final Object? error;
}

final class MercureProbe {
  const MercureProbe();

  Future<MercureProbeResult> probe({
    required String label,
    required List<String> topics,
  }) async {
    final normalizedTopics = topics.where((topic) => topic.isNotEmpty).toList();
    final subscription = await MercureClient.probeTopics(
      label: label,
      topics: normalizedTopics,
    );

    if (subscription == null) {
      debugPrint(
        'WARN [E2E][mercure] fallback=http label=$label topics=${normalizedTopics.join(",")}',
      );
      return MercureProbeResult(
        label: label,
        topics: normalizedTopics,
        connected: false,
        fallback: true,
      );
    }

    debugPrint(
      'INFO [E2E][mercure] topic=${normalizedTopics.join(",")} connected=true label=$label',
    );

    await subscription.close();
    return MercureProbeResult(
      label: label,
      topics: normalizedTopics,
      connected: true,
      fallback: false,
    );
  }
}
