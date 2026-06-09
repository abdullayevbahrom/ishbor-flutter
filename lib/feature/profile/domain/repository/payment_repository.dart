import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/datasource/transaction_status.dart';

abstract class PaymentRepository {
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
