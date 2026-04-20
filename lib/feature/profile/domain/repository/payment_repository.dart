import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/datasource/transaction_status.dart';
import '../../data/model/payment_paras.dart';

abstract class PaymentRepository{
  Future<Either<Failure, String>> makeTransaction({
    required PaymentParams paymentParams,
  });

  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required int transactionId,
  });
}