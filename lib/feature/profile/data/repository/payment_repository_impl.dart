import 'package:dartz/dartz.dart';
import 'package:top_jobs/core/exceptions/failure.dart' as app_failure;
import 'package:top_jobs/core/network/api_http.dart' as api_failure;
import 'package:top_jobs/feature/profile/data/datasource/payment_datasource.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentDataSource _dataSource;

  PaymentRepositoryImpl(this._dataSource);

  Either<app_failure.Failure, T> _mapFailure<T>(
    Either<api_failure.Failure, T> response,
  ) {
    return response.fold(
      (failure) => Left(app_failure.Failure(message: failure.message)),
      (value) => Right(value),
    );
  }

  @override
  Future<Either<app_failure.Failure, Map<String, dynamic>>> createTopUp({
    required int amount,
    String? provider,
  }) async {
    return _mapFailure(await _dataSource.createTopUp(
      amount: amount,
      provider: provider,
    ));
  }

  @override
  Future<Either<app_failure.Failure, Map<String, dynamic>>> fetchTransaction({
    required Object id,
  }) async {
    return _mapFailure(await _dataSource.fetchTransaction(id: id));
  }

  @override
  Future<Either<app_failure.Failure, TransactionStatus>> checkTransactionStatus({
    required Object transactionId,
  }) async {
    return _mapFailure(
      await _dataSource.checkTransactionStatus(transactionId: transactionId),
    );
  }

  @override
  Future<Either<app_failure.Failure, void>> payFromBalance({
    required String content,
    required Object contentId,
    required String top,
  }) async {
    return _mapFailure(await _dataSource.payFromBalance(
      content: content,
      contentId: contentId,
      top: top,
    ));
  }

  @override
  Future<Either<app_failure.Failure, String>> payByProvider({
    required String content,
    required Object contentId,
    required String top,
    required String provider,
  }) async {
    return _mapFailure(await _dataSource.payByProvider(
      content: content,
      contentId: contentId,
      top: top,
      provider: provider,
    ));
  }

  @override
  Future<Either<app_failure.Failure, void>> postPayFromBalance({
    required Object postId,
  }) async {
    return _mapFailure(await _dataSource.postPayFromBalance(postId: postId));
  }

  @override
  Future<Either<app_failure.Failure, String>> postPayByProvider({
    required Object postId,
    required String provider,
  }) async {
    return _mapFailure(
      await _dataSource.postPayByProvider(postId: postId, provider: provider),
    );
  }
}
