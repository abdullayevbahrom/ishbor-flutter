import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/exceptions/failure.dart';
import 'package:top_jobs/feature/profile/data/datasource/payment_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';
import 'package:top_jobs/feature/profile/data/model/payment_paras.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource _dataSource;

  PaymentRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, String>> makeTransaction({
    required PaymentParams paymentParams,
  }) async {
    final response = await _dataSource.makeTransaction(
      paymentParams: paymentParams,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }

  @override
  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required int transactionId,
  }) async {
    final response = await _dataSource.checkTransactionStatus(
      transactionId: transactionId,
    );

    return response.fold(
      (l) {
        return Left(Failure(message: l.message));
      },
      (r) {
        return Right(r);
      },
    );
  }
}
