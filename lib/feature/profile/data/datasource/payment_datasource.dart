import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/api_const.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';

import '../../../../core/exceptions/failure.dart';
import '../model/payment_paras.dart';

abstract class PaymentDataSource {
  Future<Either<Failure, String>> makeTransaction({
    required PaymentParams paymentParams,
  });

  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required int transactionId,
  });
}

class PaymentDataSourceImpl extends PaymentDataSource {
  final Dio _dio;

  PaymentDataSourceImpl(this._dio);

  @override
  Future<Either<Failure, String>> makeTransaction({
    required PaymentParams paymentParams,
  }) async {
    try {
      final response = await _dio.post(
        ApiConstants.paymentTransactions,
        data: paymentParams.toJson(),
      );

      if (response.statusCode == 200) {
        return Right(response.data['url']);
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required int transactionId,
  }) async {
    try {
      final response = await _dio.get(
        "payment-transactions/${transactionId}/check",
      );
      if (response.statusCode == 200) {
        return Right(TransactionStatus.fromJson(response.data));
      } else {
        if (response.data is Map<String, dynamic>) {
          return Left(Failure(message: response.data['message']));
        } else {
          return Left(Failure(message: response.data));
        }
      }
    } on DioException catch (e) {
      final failure = DioFailure.fromDioError(e);
      return Left(Failure(message: failure.message));
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
