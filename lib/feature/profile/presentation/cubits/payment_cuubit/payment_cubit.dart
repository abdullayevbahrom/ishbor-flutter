import 'package:easy_localization/easy_localization.dart';
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

  PaymentCubit(this._paymentRepository) : super(const PaymentState());

  Future<void> makePayment(PaymentParams params) async {
    emit(state.copyWith(status: RequestStatus.loading));

    final response = await _paymentRepository.makeTransaction(
      paymentParams: params,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorDialog(
          body: LocaleKeys.smthGotWrong.tr(),
          lottiePath: AppLottie.error,
        );
        showErrorToast(l.message);
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        AppLauncher().launchURL(r);
      },
    );
  }

  Future<void> checkTransactionStatus(int transactionId) async {
    emit(state.copyWith(status: RequestStatus.loading));
    final response = await _paymentRepository.checkTransactionStatus(
      transactionId: transactionId,
    );

    response.fold(
      (l) {
        emit(state.copyWith(status: RequestStatus.error));
        showErrorToast(LocaleKeys.smthGotWrong.tr());
      },
      (r) {
        emit(state.copyWith(status: RequestStatus.loaded));
        if (r.status == Status.completed) {
          showSuccessToast(LocaleKeys.payment_completed.tr());
          navigatorKey.currentContext?.read<UserCubit>().fetchUser();
          navigatorKey.currentContext?.go(Routes.main);
        }

        if (r.status == Status.processing) {
          showWarningToast(LocaleKeys.payment_processing.tr());
        }

        if (r.status == Status.pending) {
          showWarningToast(LocaleKeys.payment_pending.tr());
        }

        if (r.status == Status.cancelled) {
          showErrorToast(LocaleKeys.payment_cancelled.tr());
        }
      },
    );
  }
}
