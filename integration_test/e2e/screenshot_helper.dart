import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as p;

import 'e2e_config.dart';

final class ScreenshotArtifact {
  const ScreenshotArtifact({
    required this.order,
    required this.route,
    required this.state,
    required this.file,
    required this.timestamp,
    required this.apiCalls,
  });

  final int order;
  final String route;
  final String state;
  final String file;
  final String timestamp;
  final List<Map<String, dynamic>> apiCalls;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order': order,
        'route': route,
        'state': state,
        'file': file,
        'timestamp': timestamp,
        'api_calls': apiCalls,
      };
}

final class E2EScreenshotHelper {
  E2EScreenshotHelper({
    required this.binding,
    required this.config,
    required this.apiCalls,
  });

  final IntegrationTestWidgetsFlutterBinding binding;
  final E2EConfig config;
  final List<Map<String, dynamic>> apiCalls;

  Directory get outputDir => Directory(
    p.join('var', 'screnshots', config.runId),
  );

  File get manifestFile => File(p.join(outputDir.path, 'manifest.json'));

  Future<void> prepare() async {
    await outputDir.create(recursive: true);
    if (defaultTargetPlatform == TargetPlatform.android) {
      await binding.convertFlutterSurfaceToImage();
    }
    binding.reportData = _reportData();
    await _persistManifest(const <ScreenshotArtifact>[]);
  }

  Future<File> capture({
    required WidgetTester tester,
    required String route,
    required String state,
    required int order,
  }) async {
    await tester.pumpAndSettle();
    final safeRoute = _slug(route);
    final safeState = _slug(state);
    final orderPrefix = order.toString().padLeft(2, '0');
    final screenshotNameBuffer = StringBuffer(orderPrefix)
      ..write('_')
      ..write(safeRoute)
      ..write('_')
      ..write(safeState)
      ..write('.png');
    final screenshotName = screenshotNameBuffer.toString();
    final screenshotPath = p.join(outputDir.path, screenshotName);

    try {
      final bytes = await binding.takeScreenshot(screenshotName);
      final file = File(screenshotPath);
      await file.writeAsBytes(bytes, flush: true);

      final artifact = ScreenshotArtifact(
        order: order,
        route: route,
        state: state,
        file: screenshotName,
        timestamp: DateTime.now().toUtc().toIso8601String(),
        apiCalls: List<Map<String, dynamic>>.from(apiCalls),
      );
      await _appendArtifact(artifact);
      debugPrint(
        '[DEBUG][E2E][shot] route=$route step=$state file=$screenshotName',
      );
      return file;
    } catch (error) {
      debugPrint(
        '[ERROR][E2E][shot] route=$route step=$state file=$screenshotName error=$error',
      );
      rethrow;
    }
  }

  Future<File> captureFailure({
    required WidgetTester tester,
    required String testName,
  }) async {
    final failureName = 'failure_${_slug(testName)}.png';
    final failurePath = p.join(outputDir.path, failureName);
    try {
      final bytes = await binding.takeScreenshot(failureName);
      final file = File(failurePath);
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (_) {
      return File(failurePath);
    }
  }

  Future<void> finalize({required String status}) async {
    final data = await _readManifest();
    data['status'] = status;
    data['api_calls'] = List<Map<String, dynamic>>.from(apiCalls);
    data['updated_at'] = DateTime.now().toUtc().toIso8601String();
    await manifestFile.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
      flush: true,
    );
    binding.reportData = _reportData(status: status);
  }

  Map<String, dynamic> _reportData({String status = 'running'}) {
    return <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': status,
      'api_calls': List<Map<String, dynamic>>.from(apiCalls),
    };
  }

  Future<void> _appendArtifact(ScreenshotArtifact artifact) async {
    final data = await _readManifest();
    final screenshots = (data['screenshots'] as List<dynamic>? ?? <dynamic>[])
      ..add(artifact.toJson());
    data['screenshots'] = screenshots;
    data['api_calls'] = List<Map<String, dynamic>>.from(apiCalls);
    data['updated_at'] = DateTime.now().toUtc().toIso8601String();
    await manifestFile.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
      flush: true,
    );
    binding.reportData = _reportData();
  }

  Future<Map<String, dynamic>> _readManifest() async {
    if (!await manifestFile.exists()) {
      return <String, dynamic>{
        'run_id': config.runId,
        'api_base_url': config.apiBaseUrl,
        'mercure_public_url': config.mercurePublicUrl,
        'device': defaultTargetPlatform.name,
        'status': 'running',
        'screenshots': <dynamic>[],
        'api_calls': <dynamic>[],
        'created_at': DateTime.now().toUtc().toIso8601String(),
      };
    }

    final content = await manifestFile.readAsString();
    final decoded = jsonDecode(content);
    if (decoded is Map<String, dynamic>) {
      return Map<String, dynamic>.from(decoded);
    }

    return <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': 'running',
      'screenshots': <dynamic>[],
      'api_calls': <dynamic>[],
      'created_at': DateTime.now().toUtc().toIso8601String(),
    };
  }

  Future<void> _persistManifest(List<ScreenshotArtifact> artifacts) async {
    final payload = <String, dynamic>{
      'run_id': config.runId,
      'api_base_url': config.apiBaseUrl,
      'mercure_public_url': config.mercurePublicUrl,
      'device': defaultTargetPlatform.name,
      'status': 'running',
      'screenshots': artifacts.map((artifact) => artifact.toJson()).toList(),
      'api_calls': List<Map<String, dynamic>>.from(apiCalls),
      'created_at': DateTime.now().toUtc().toIso8601String(),
    };
    await manifestFile.writeAsString(
      const JsonEncoder.withIndent('  ').convert(payload),
      flush: true,
    );
  }

  String _slug(String value) {
    final normalized = value.trim().toLowerCase();
    final buffer = StringBuffer();
    var lastWasDash = false;

    for (final rune in normalized.runes) {
      final char = String.fromCharCode(rune);
      final isAlphaNumeric = RegExp(r'[a-z0-9]').hasMatch(char);
      if (isAlphaNumeric) {
        buffer.write(char);
        lastWasDash = false;
        continue;
      }
      if (!lastWasDash) {
        buffer.write('-');
        lastWasDash = true;
      }
    }

    final slug = buffer.toString().replaceAll(RegExp(r'-+'), '-');
    return slug.replaceAll(RegExp(r'^-+|-+$'), '');
  }
}
