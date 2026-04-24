import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/api_const.dart';
import '../services/storage_service.dart';
import 'dio_interceptor.dart';

class DioClient {
  final StorageService _storageService;

  DioClient({required StorageService storageService})
    : _storageService = storageService;

  Dio provideDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        sendTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );

    if (ApiConstants.apiHostHeader.isNotEmpty) {
      dio.options.headers[HttpHeaders.hostHeader] = ApiConstants.apiHostHeader;
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
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 100,
        enabled: kDebugMode,
      ),
    ); // Logging

    return dio;
  }
}
