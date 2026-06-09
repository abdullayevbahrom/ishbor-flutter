import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/exceptions/failure.dart';
import 'package:top_jobs/feature/profile/data/datasource/payment_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource _dataSource;

  PaymentRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  }) {
    return _dataSource.createTopUp(amount: amount, provider: provider);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> fetchTransaction({required Object id}) {
    return _dataSource.fetchTransaction(id: id);
  }

  @override
  Future<Either<Failure, TransactionStatus>> checkTransactionStatus({
    required Object transactionId,
  }) {
    return _dataSource.checkTransactionStatus(transactionId: transactionId);
  }

  @override
  Future<Either<Failure, void>> payFromBalance({
    required String content,
    required Object contentId,
    required String top,
  }) {
    return _dataSource.payFromBalance(content: content, contentId: contentId, top: top);
  }

  @override
  Future<Either<Failure, String>> payByProvider({
    required String content,
    required Object contentId,
    required String top,
    required String provider,
  }) {
    return _dataSource.payByProvider(
      content: content,
      contentId: contentId,
      top: top,
      provider: provider,
    );
  }

  @override
  Future<Either<Failure, void>> postPayFromBalance({required Object postId}) {
    return _dataSource.postPayFromBalance(postId: postId);
  }

  @override
  Future<Either<Failure, String>> postPayByProvider({
    required Object postId,
    required String provider,
  }) {
    return _dataSource.postPayByProvider(postId: postId, provider: provider);
  }
}
