import 'package:top_jobs/core/services/storage_service.dart';

import '../mercure_probe.dart';

final class RealtimeFlow {
  const RealtimeFlow({this.probe = const MercureProbe()});

  final MercureProbe probe;

  Future<List<MercureProbeResult>> run({
    required String userId,
    String? dialogId,
  }) async {
    await StorageService.instance.putUserId(userId);

    final results = <MercureProbeResult>[];
    results.add(
      await probe.probe(
        label: 'notifications',
        topics: ['users/$userId/notifications'],
      ),
    );
    results.add(
      await probe.probe(label: 'status', topics: ['users/status/$userId']),
    );
    results.add(
      await probe.probe(
        label: 'status-check',
        topics: ['users/status/check/$userId'],
      ),
    );

    if (dialogId != null && dialogId.isNotEmpty) {
      results.add(
        await probe.probe(
          label: 'messages',
          topics: ['chats/$dialogId/messages'],
        ),
      );
    }

    return results;
  }
}
