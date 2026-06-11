import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/core/helpers/enum_helpers.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';
import 'package:top_jobs/feature/profile/data/datasource/transaction_status.dart';
import 'package:top_jobs/feature/profile/data/model/payment_paras.dart';
import 'package:top_jobs/feature/profile/domain/repository/payment_repository.dart';

import '../../../../../core/theme/app_lottie.dart';

part 'payment_state.dart';

part 'payment_cubit.freezed.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;
  Timer? _pollTimer;
  String? _activeTransactionId;

  PaymentCubit(this._paymentRepository) : super(const PaymentState());

  Future<void> makePayment(PaymentParams params) async {
    emit(state.copyWith(status: RequestStatus.loading));

    debugPrint(
      '[DEBUG][payment] createTopUp amount=${params.amount} provider=${params.provider}',
    );
    final response = await _paymentRepository.createTopUp(
      amount: int.parse(params.amount.replaceAll(' ', '')),
      provider: params.provider,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        debugPrint('[WARN][payment] provider failure ${l.message}');
        showErrorDialog(
          body: LocaleKeys.smthGotWrong.tr(),
          lottiePath: AppLottie.error,
        );
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        final paymentLink = _extractPaymentLink(r);
        final transactionId = _extractTransactionId(r);
        debugPrint(
          '[DEBUG][payment] createTopUp result transactionId=${transactionId?.toString() ?? ''} hasLink=${paymentLink.isNotEmpty}',
        );
        if (paymentLink.isNotEmpty) {
          AppLauncher().launchURL(paymentLink);
        } else {
          showWarningToast(LocaleKeys.smthGotWrong.tr());
        }

        if (transactionId != null) {
          startTransactionPolling(transactionId);
        }
      },
    );
  }

  Future<void> startTransactionPolling(String transactionId) async {
    _activeTransactionId = transactionId;
    _pollTimer?.cancel();
    debugPrint('[DEBUG][payment][poll] start transactionId=$transactionId');
    final initialStatus = await _pollTransactionStatus(
      transactionId,
      showFeedback: false,
    );
    if (initialStatus == null ||
        initialStatus.status == Status.completed ||
        initialStatus.status == Status.cancelled) {
      return;
    }
    _pollTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final activeId = _activeTransactionId;
      if (activeId == null) {
        timer.cancel();
        return;
      }
      final status = await _pollTransactionStatus(
        activeId,
        showFeedback: false,
      );
      if (status == null) {
        return;
      }
      if (status.status == Status.completed || status.status == Status.cancelled) {
        timer.cancel();
      }
    });
  }

  Future<void> checkTransactionStatus(String transactionId) async {
    _activeTransactionId = transactionId;
    _pollTimer?.cancel();
    debugPrint('[DEBUG][payment][poll] manual check transactionId=$transactionId');
    await _pollTransactionStatus(transactionId, showFeedback: true);
  }

  Future<TransactionStatus?> _pollTransactionStatus(
    int transactionId, {
    required bool showFeedback,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _paymentRepository.checkTransactionStatus(
      transactionId: transactionId,
    );

    return response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        debugPrint(
          '[WARN][payment][poll] failed transactionId=$transactionId error=${l.message}',
        );
        if (showFeedback) {
          showErrorToast(LocaleKeys.smthGotWrong.tr());
        }
        return null;
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        debugPrint(
          '[DEBUG][payment][poll] transactionId=$transactionId status=${r.status.toJson()} success=${r.success}',
        );
        if (r.status == Status.completed) {
          _pollTimer?.cancel();
          _activeTransactionId = null;
          showSuccessToast(LocaleKeys.payment_completed.tr());
          navigatorKey.currentContext?.read<UserCubit>().fetchUser();
          navigatorKey.currentContext?.go(Routes.main);
        }

        if (showFeedback && r.status == Status.processing) {
          showWarningToast(LocaleKeys.payment_processing.tr());
        }

        if (showFeedback && r.status == Status.pending) {
          showWarningToast(LocaleKeys.payment_pending.tr());
        }

        if (r.status == Status.cancelled) {
          _pollTimer?.cancel();
          _activeTransactionId = null;
          if (showFeedback) {
            showErrorToast(LocaleKeys.payment_cancelled.tr());
          }
        }
        return r;
      },
    );
  }

  String _extractPaymentLink(Map<String, dynamic> response) {
    final data = response['data'];
    if (data is Map<String, dynamic>) {
      final nestedUrl =
          data['url']?.toString() ??
          data['payment_url']?.toString() ??
          data['payment_link']?.toString();
      if (nestedUrl != null && nestedUrl.isNotEmpty) {
        return nestedUrl;
      }
    }

    final directUrl =
        response['url']?.toString() ??
        response['payment_url']?.toString() ??
        response['payment_link']?.toString();
    return directUrl ?? '';
  }

  String? _extractTransactionId(Map<String, dynamic> response) {
    final candidates = <dynamic>[
      response['transaction_id'],
      response['id'],
      response['payment_transaction_id'],
      if (response['data'] is Map<String, dynamic>)
        (response['data'] as Map<String, dynamic>)['transaction_id'],
      if (response['data'] is Map<String, dynamic>)
        (response['data'] as Map<String, dynamic>)['id'],
    ];

    for (final candidate in candidates) {
      if (candidate is int) {
        return candidate.toString();
      }
      if (candidate is String && candidate.isNotEmpty) {
        return candidate;
      }
    }

    return null;
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
