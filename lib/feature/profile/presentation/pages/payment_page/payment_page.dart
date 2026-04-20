import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/profile/data/model/payment_paras.dart';
import 'package:top_jobs/feature/profile/presentation/cubits/payment_cuubit/payment_cubit.dart';
import 'package:top_jobs/feature/profile/presentation/pages/payment_page/widgets/w_payment_amount.dart';
import 'package:top_jobs/feature/profile/presentation/pages/payment_page/widgets/w_payment_type.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key, this.transactionId});

  final int? transactionId;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (transactionId != null) {
        context.read<PaymentCubit>()..checkTransactionStatus(transactionId!);
      }
    });
    return WPaymentBody();
  }
}

class WPaymentBody extends StatefulWidget {
  const WPaymentBody({super.key});

  @override
  State<WPaymentBody> createState() => _WPaymentBodyState();
}

class _WPaymentBodyState extends State<WPaymentBody> {
  late TextEditingController _amountController;
  final _formKey = GlobalKey<FormState>();
  int currentIndex = -1;

  @override
  void initState() {
    _amountController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        return WLayout(
          child: Scaffold(
            backgroundColor: AppColors.cFFFFFF,
            body: Form(
              key: _formKey,

              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  AppHeader(isPopAvailable: true),
                  Expanded(
                    child: SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          40.verticalSpace,
                          Text(
                            LocaleKeys.balanceRefill.tr(),
                            style: AppTextStyles.size28Bold.copyWith(
                              color: AppColors.c2E3A59,
                            ),
                          ).paddingSymmetric(horizontal: 16.w),
                          24.verticalSpace,
                          WPaymentTypes(
                            onPressedPaymentType: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            currentIndex: currentIndex,
                          ),
                          22.verticalSpace,
                          WDecoratedBox(
                            radius: 16.r,
                            bgColor: AppColors.cFBFBFD,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(
                                      text: LocaleKeys.balance.tr(),
                                      style: AppTextStyles.size24Medium
                                          .copyWith(color: AppColors.c2E3A59),
                                      children: [
                                        TextSpan(
                                          text:
                                              " ${"${(context.read<UserCubit>().state.user?.balance ?? 0)}"} ${LocaleKeys.sum.tr()}",
                                          style: AppTextStyles.size24Bold
                                              .copyWith(
                                                color: AppColors.cFF9914,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                15.verticalSpace,
                                WPaymentAmount(
                                  onPressedAmount: (amount) {
                                    setState(() {
                                      _amountController.text = amount;
                                    });
                                  },
                                  currentValue: _amountController.text.trim(),
                                ),
                                22.verticalSpace,
                                Text(
                                  LocaleKeys.rechargeAmount.tr(),
                                  style: AppTextStyles.size15Regular.copyWith(
                                    color: AppColors.cB7BFCA,
                                  ),
                                ),
                                5.verticalSpace,
                                AppTextFormField(
                                  maxLines: 1,
                                  minLines: 1,
                                  hintText: LocaleKeys.enterAmount.tr(),
                                  controller: _amountController,
                                  keyBoardType: TextInputType.number,
                                  // suffixIcon: SizedBox(
                                  //   height: 60.h,
                                  //   child: Text(
                                  //     LocaleKeys.sum.tr(),
                                  //     style: AppTextStyles.size17Bold.copyWith(
                                  //       color: AppColors.c333333,
                                  //     ),
                                  //   ).paddingOnly(right: 7.w, top: 2.h),
                                  // ),
                                  formatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    MoneyInputFormatter(),
                                  ],
                                  validator: (value) {
                                    return ValidatorHelpers.validateField(
                                      value: value!,
                                    );
                                  },
                                  onChanged: (value) {},
                                ),
                              ],
                            ).paddingAll(16.r),
                          ).paddingSymmetric(horizontal: 16.w),
                          17.verticalSpace,
                          SizedBox(
                            height: 50.h,
                            child: AppButton(
                              width: 100.sw,
                              isLoading: state.status.isLoading(),
                              onPressed: () {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  context.read<PaymentCubit>().makePayment(
                                    PaymentParams(
                                      provider: makePaymentType(currentIndex),
                                      amount: _amountController.text
                                          .trim()
                                          .replaceAll(" ", ''),
                                    ),
                                  );
                                }
                              },
                              leftIcon: SvgPicture.asset(
                                AppSvg.icPayment,
                              ).paddingOnly(right: 10.w),
                              textStyle: AppTextStyles.size17Medium.copyWith(
                                color: AppColors.cFFFFFF,
                              ),
                              text: LocaleKeys.pay.tr(),
                              color: AppColors.c15CF74,
                            ).paddingSymmetric(horizontal: 16.w),
                          ),
                          20.verticalSpace,
                          Footer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove any non-digit characters
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // If empty, return empty
    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    // Format the number with spaces (assuming that's what Formatters.moneyFormat does)
    String formatted = formatMoney(digitsOnly);

    // Calculate the new cursor position
    int newCursorPosition = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }

  // Replace this with your actual Formatters.moneyFormat logic
  String formatMoney(String value) {
    if (value.isEmpty) return '';

    // Add spaces every 3 digits from the right
    String reversed = value.split('').reversed.join('');
    String formatted = '';

    for (int i = 0; i < reversed.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formatted += ' ';
      }
      formatted += reversed[i];
    }

    return formatted.split('').reversed.join('');
  }
}

String makePaymentType(int index) {
  switch (index) {
    case 0:
      return "click";
    case 1:
      return "payme";
    case 2:
      return "uzum";
    case 3:
      return "paynet";
    case 4:
      return "alif";
    case 5:
      return "cash";
    default:
      return 'click';
  }
}
