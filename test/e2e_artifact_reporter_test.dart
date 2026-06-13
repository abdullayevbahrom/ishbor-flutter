import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../integration_test/e2e/artifact_reporter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('artifact reporter writes coverage and failures outputs', () async {
    final tempDir = await Directory.systemTemp.createTemp('e2e-artifact');
    addTearDown(() async {
      if (await tempDir.exists()) {
        await tempDir.delete(recursive: true);
      }
    });

    final manifestFile = File('${tempDir.path}/manifest.json');
    await manifestFile.writeAsString(
      jsonEncode(<String, dynamic>{
        'run_id': 'run-1',
        'api_base_url': 'http://api.example.test',
        'app_version': '1.2.3',
        'device': 'android',
        'status': 'running',
        'screenshots': <Map<String, dynamic>>[
          <String, dynamic>{
            'order': 1,
            'route': 'new-version',
            'state': 'loaded',
            'file': '01_new_version_loaded.png',
            'timestamp': DateTime.now().toUtc().toIso8601String(),
            'api_calls': <Map<String, dynamic>>[],
          },
        ],
      }),
    );

    final result = await E2EArtifactReporter.generate(
      outputDir: tempDir,
      manifestFile: manifestFile,
      runId: 'run-1',
      apiBaseUrl: 'http://api.example.test',
      appVersion: '1.2.3',
      device: 'android',
      enforceCoverage: false,
    );

    expect(result.screenshotCount, 1);
    expect(result.coveredCount, greaterThan(0));
    expect(result.missingCount, greaterThan(0));
    expect(File('${tempDir.path}/coverage.md').existsSync(), isTrue);
    expect(File('${tempDir.path}/failures.log').existsSync(), isTrue);
  });
}
