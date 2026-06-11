import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../consts.dart';
import '../services/storage_service.dart';
import 'dio_interceptor.dart';

class DioClient {
  final StorageService _storageService;

  DioClient({required StorageService storageService})
    : _storageService = storageService;

  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (kDebugMode) {
      debugPrint(
        '[DIO][env] appEnvironment=$appEnvironment baseUrl=$apiBaseUrl',
      );
    }

    if (Platform.isAndroid) {
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        if (kDebugMode) {
          client.badCertificateCallback = (cert, host, port) {
            debugPrint('⚠️ Bad certificate for $host:$port ignored');
            return true;
          };
        }
        client.connectionTimeout = const Duration(seconds: 30);

        return client;
      };
    }

    dio.interceptors.add(DioInterceptors(_storageService, dio));
    return dio;
  }
}
