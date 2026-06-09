import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';

import '../../../../core/network/api_http.dart';
import '../model/payment_paras.dart';

abstract class PaymentDataSource {
  Future<Either<Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  });

  Future<Either<Failure, Map<String, dynamic>>> fetchTransaction({required Object id});

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

  @override
  Future<Either<Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.paymentTransactions,
        data: {
          'amount': amount,
          if (provider != null) 'provider': provider,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return Right(Map<String, dynamic>.from(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchTransaction({required Object id}) async {
    try {
      final response = await _dio.get(ApiConstants.fetchPaymentTransaction(id));
      if (response.statusCode == 200) {
        return Right(Map<String, dynamic>.from(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
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
      final response = await _dio.get(ApiConstants.checkPaymentTransaction(transactionId));
      if (response.statusCode == 200) {
        return Right(TransactionStatus.fromJson(response.data['data'] ?? response.data));
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
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
      final response = await _dio.post(ApiConstants.payFromBalance(content, contentId, top));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
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
      final response = await _dio.post(ApiConstants.payByProvider(content, contentId, top, provider));
      if (response.statusCode == 200) {
        return Right(response.data['data']?['url'] ?? response.data['url']?.toString() ?? '');
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
      return Left(Failure(message: DioFailure.fromDioError(e).message));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, void>> postPayFromBalance({required Object postId}) async {
    try {
      final response = await _dio.post(ApiConstants.postPayFromBalance(postId));
      if (response.statusCode == 204 || response.statusCode == 200) {
        return const Right(null);
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
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
      final response = await _dio.post(ApiConstants.postPayByProvider(postId, provider));
      if (response.statusCode == 200) {
        return Right(response.data['data']?['url'] ?? response.data['url']?.toString() ?? '');
      } else {
        return Left(Failure(message: _extractMessage(response.data)));
      }
    } on DioException catch (e) {
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
