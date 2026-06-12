import 'dart:io';

final class E2EMockLocation {
  const E2EMockLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory E2EMockLocation.fromEnvironment(Map<String, String> env) {
    final latitude = double.tryParse(env['E2E_MOCK_LOCATION_LAT'] ?? '');
    final longitude = double.tryParse(env['E2E_MOCK_LOCATION_LNG'] ?? '');
    return E2EMockLocation(
      latitude: latitude ?? 41.311081,
      longitude: longitude ?? 69.240562,
      address:
          env['E2E_FALLBACK_ADDRESS']?.trim().isNotEmpty == true
              ? env['E2E_FALLBACK_ADDRESS']!.trim()
              : "Chilonzor tumani, Bunyodkor shoh ko'chasi",
    );
  }

  final double latitude;
  final double longitude;
  final String address;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
      };
}

final class E2EDeviceSetup {
  const E2EDeviceSetup({
    required this.packageName,
    required this.fixtureRoot,
    required this.downloadDirectory,
    required this.permissions,
    required this.fixtures,
    required this.mockLocation,
  });

  factory E2EDeviceSetup.fromEnvironment([Map<String, String>? environment]) {
    final env = environment ?? Platform.environment;
    final fixtureRoot =
        env['E2E_FIXTURE_ROOT']?.trim().isNotEmpty == true
            ? env['E2E_FIXTURE_ROOT']!.trim()
            : 'integration_test/fixtures';

    return E2EDeviceSetup(
      packageName: env['E2E_ANDROID_PACKAGE']?.trim().isNotEmpty == true
          ? env['E2E_ANDROID_PACKAGE']!.trim()
          : 'uz.ishbor.app.com',
      fixtureRoot: fixtureRoot,
      downloadDirectory: env['E2E_DEVICE_DOWNLOAD_DIR']?.trim().isNotEmpty ==
              true
          ? env['E2E_DEVICE_DOWNLOAD_DIR']!.trim()
          : '/sdcard/Download/ishbor-e2e',
      permissions: const <String>[
        'android.permission.ACCESS_COARSE_LOCATION',
        'android.permission.ACCESS_FINE_LOCATION',
        'android.permission.CAMERA',
        'android.permission.POST_NOTIFICATIONS',
        'android.permission.READ_EXTERNAL_STORAGE',
        'android.permission.READ_MEDIA_AUDIO',
        'android.permission.READ_MEDIA_IMAGES',
        'android.permission.READ_MEDIA_VIDEO',
        'android.permission.WRITE_EXTERNAL_STORAGE',
      ],
      fixtures: const <E2EFixtureAsset>[
        E2EFixtureAsset(
          source: 'sample_image.png.b64',
          destination: 'sample_image.png',
          mimeType: 'image/png',
          description: '1x1 PNG used by image picker fallback coverage',
        ),
        E2EFixtureAsset(
          source: 'sample_document.txt',
          destination: 'sample_document.txt',
          mimeType: 'text/plain',
          description: 'Plain text file used by file picker fallback coverage',
        ),
        E2EFixtureAsset(
          source: 'mock_location.json',
          destination: 'mock_location.json',
          mimeType: 'application/json',
          description: 'Deterministic fallback location fixture',
        ),
      ],
      mockLocation: E2EMockLocation.fromEnvironment(env),
    );
  }

  final String packageName;
  final String fixtureRoot;
  final String downloadDirectory;
  final List<String> permissions;
  final List<E2EFixtureAsset> fixtures;
  final E2EMockLocation mockLocation;

  String describeForLog() {
    return [
      'package=$packageName',
      'fixtureRoot=$fixtureRoot',
      'downloadDirectory=$downloadDirectory',
      'permissions=${permissions.length}',
      'fixtures=${fixtures.length}',
      'mockLocation=${mockLocation.latitude},${mockLocation.longitude}',
    ].join(' ');
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'package_name': packageName,
        'fixture_root': fixtureRoot,
        'download_directory': downloadDirectory,
        'permissions': permissions,
        'fixtures': fixtures.map((fixture) => fixture.toJson()).toList(),
        'mock_location': mockLocation.toJson(),
      };
}

final class E2EFixtureAsset {
  const E2EFixtureAsset({
    required this.source,
    required this.destination,
    required this.mimeType,
    required this.description,
  });

  final String source;
  final String destination;
  final String mimeType;
  final String description;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'source': source,
        'destination': destination,
        'mime_type': mimeType,
        'description': description,
      };
}
