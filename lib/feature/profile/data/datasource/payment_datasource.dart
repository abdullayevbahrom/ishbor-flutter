import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';
import '../../../../core/network/api_http.dart';

abstract class PaymentDataSource {
  Future<Either<Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  });

  Future<Either<Failure, Map<String, dynamic>>> fetchTransaction({
    required Object id,
  });

  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required Object transactionId,
  });

  Future<Either<Failure, void>> payFromBalance({
    required String content,
    required Object contentId,
    required String top,
  });

  Future<Either<Failure, String>> payByProvider({
    required String content,
    required Object contentId,
    required String top,
    required String provider,
  });

  Future<Either<Failure, void>> postPayFromBalance({required Object postId});

  Future<Either<Failure, String>> postPayByProvider({
    required Object postId,
    required String provider,
  });
}

class PaymentDataSourceImpl extends PaymentDataSource {
  final Dio _dio;

  PaymentDataSourceImpl(this._dio);

  void _logProviderFailure(String label, DioException error) {
    final statusCode = error.response?.statusCode;
    if (statusCode != null && statusCode >= 400) {
      debugPrint(
        '[WARN][payment][$label] provider failure status=$statusCode message=${error.message ?? ''}',
      );
    }
  }

  String _extractPaymentLink(dynamic source) {
    final data = source is Map<String, dynamic> ? source['data'] : null;
    if (data is Map<String, dynamic>) {
      final nested =
          data['url']?.toString() ??
          data['payment_url']?.toString() ??
          data['payment_link']?.toString();
      if (nested != null && nested.isNotEmpty) {
        return nested;
      }
    }

    if (source is Map<String, dynamic>) {
      final direct =
          source['url']?.toString() ??
          source['payment_url']?.toString() ??
          source['payment_link']?.toString();
      return direct ?? '';
    }

    return '';
  }

  void _logTransaction(String label, Object id, [dynamic payload]) {
    debugPrint(
      '[DEBUG][payment][$label] transactionId=${id.toString()} payload=${payload?.toString() ?? ''}',
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  }) async {
    try {
      debugPrint(
        '[DEBUG][payment][create] amount=$amount provider=${provider ?? ''}',
      );
      final response = await _dio.post(
        ApiConstants.paymentTransactions,
        data: {'amount': amount, if (provider != null) 'provider': provider},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final payload = Map<String, dynamic>.from(response.data['data'] ?? response.data);
        debugPrint(
          '[DEBUG][payment][create] transactionId=${payload['id']?.toString() ?? ''} hasLink=${_extractPaymentLink(payload).isNotEmpty}',
        );
        return Right(payload);
      } else {
        debugPrint(
          '[WARN][payment][create] unexpected status=${response.statusCode}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('create', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchTransaction({
    required Object id,
  }) async {
    try {
      _logTransaction('read', id);
      final response = await _dio.get(ApiConstants.fetchPaymentTransaction(id));
      if (response.statusCode == 200) {
        final payload = Map<String, dynamic>.from(response.data['data'] ?? response.data);
        debugPrint(
          '[DEBUG][payment][read] transactionId=${id.toString()} status=${payload['status']?.toString() ?? ''}',
        );
        return Right(payload);
      } else {
        debugPrint(
          '[WARN][payment][read] unexpected status=${response.statusCode} transactionId=${id.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('read', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required Object transactionId,
  }) async {
    try {
      _logTransaction('poll', transactionId);
      final response = await _dio.get(
        ApiConstants.checkPaymentTransaction(transactionId),
      );
      if (response.statusCode == 200) {
        final payload = response.data['data'] ?? response.data;
        final status = TransactionStatus.fromJson(payload);
        debugPrint(
          '[DEBUG][payment][poll] transactionId=${transactionId.toString()} status=${status.status.toJson()} success=${status.success}',
        );
        return Right(status);
      } else {
        debugPrint(
          '[WARN][payment][poll] unexpected status=${response.statusCode} transactionId=${transactionId.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('poll', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> payFromBalance({
    required String content,
    required Object contentId,
    required String top,
  }) async {
    try {
      debugPrint(
        '[DEBUG][payment][balance] content=$content contentId=${contentId.toString()} top=$top',
      );
      final response = await _dio.post(
        ApiConstants.payFromBalance(content, contentId, top),
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        debugPrint(
          '[WARN][payment][balance] unexpected status=${response.statusCode} content=$content contentId=${contentId.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('balance', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> payByProvider({
    required String content,
    required Object contentId,
    required String top,
    required String provider,
  }) async {
    try {
      debugPrint(
        '[DEBUG][payment][provider] content=$content contentId=${contentId.toString()} top=$top provider=$provider',
      );
      final response = await _dio.post(
        ApiConstants.payByProvider(content, contentId, top, provider),
      );
      if (response.statusCode == 200) {
        final url = _extractPaymentLink(response.data);
        if (url.isEmpty) {
          debugPrint(
            '[WARN][payment][provider] missing payment link provider=$provider content=$content contentId=${contentId.toString()}',
          );
          return Left(Failure(message: _extractMessage(response.data)));
        }
        return Right(url);
      } else {
        debugPrint(
          '[WARN][payment][provider] unexpected status=${response.statusCode} provider=$provider content=$content contentId=${contentId.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('provider', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> postPayFromBalance({
    required Object postId,
  }) async {
    try {
      debugPrint('[DEBUG][payment][post-balance] postId=${postId.toString()}');
      final response = await _dio.post(ApiConstants.postPayFromBalance(postId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        debugPrint(
          '[WARN][payment][post-balance] unexpected status=${response.statusCode} postId=${postId.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('post-balance', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> postPayByProvider({
    required Object postId,
    required String provider,
  }) async {
    try {
      debugPrint(
        '[DEBUG][payment][post-provider] postId=${postId.toString()} provider=$provider',
      );
      final response = await _dio.post(
        ApiConstants.postPayByProvider(postId, provider),
      );
      if (response.statusCode == 200) {
        final url = _extractPaymentLink(response.data);
        if (url.isEmpty) {
          debugPrint(
            '[WARN][payment][post-provider] missing payment link provider=$provider postId=${postId.toString()}',
          );
          return Left(Failure(message: _extractMessage(response.data)));
        }
        return Right(url);
      } else {
        debugPrint(
          '[WARN][payment][post-provider] unexpected status=${response.statusCode} provider=$provider postId=${postId.toString()}',
        );
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      _logProviderFailure('post-provider', e);
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? data.toString();
    }
    return data?.toString() ?? 'Unknown error';
  }
}
