import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/validators.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/app_text_form_field.dart';
import '../../../../../profile/presentation/pages/payment_page/payment_page.dart';

class WTaskApply extends StatefulWidget {
  WTaskApply({
    super.key,
    required this.onPressedSend,
    required this.isLoading,
    required this.descriptionController,
    required this.priceController,
  });

  final VoidCallback onPressedSend;
  final bool isLoading;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            color: AppColors.cFFFFFF,
            child: this.paddingSymmetric(horizontal: 18.w),
          ),
        );
      },
    );
  }

  @override
  State<WTaskApply> createState() => _WTaskApplyState();
}

class _WTaskApplyState extends State<WTaskApply> {
  final _formKey = GlobalKey<FormState>();
  int currentLength = 0;
  int maxLength = 120;
  String currency = LocaleKeys.sum.tr();

  int? _parsePrice(String value) {
    final normalized = value.trim().replaceAll(" ", "");
    return normalized.isEmpty ? null : int.tryParse(normalized);
  }

  @override
  void initState() {
    final initialPrice = _parsePrice(widget.priceController.text);
    if (initialPrice != null) {
      if (initialPrice > 50000) {
        setState(() {
          currency = LocaleKeys.sum.tr();
        });
      } else {
        setState(() {
          currency = "USD";
        });
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SizedBox(
        width: 100.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.verticalSpace,
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 5.h,
                width: 95.w,
                decoration: BoxDecoration(
                  color: AppColors.cE0E5EB,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            22.verticalSpace,
            Text(
              LocaleKeys.whyDoYouThinkIShouldConsiderYou.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.size22Bold.copyWith(
                color: AppColors.c2E3A59,
              ),
            ),
            30.verticalSpace,
            AppTextFormField(
              minLines: 7,
              maxLines: 100,
              borderRadius: 12.r,
              currentLength: currentLength,
              maxLength: maxLength,
              hintText: LocaleKeys.message.tr(),
              controller: widget.descriptionController,
              fillColor: AppColors.cFFFFFF,
              formatters: [LengthLimitingTextInputFormatter(maxLength)],
              onChanged: (value) {
                setState(() {
                  currentLength = value.length;
                });
              },
              validator: (value) {
                if (value != null) {
                  return ValidatorHelpers.validateField(value: value);
                } else {
                  return null;
                }
              },
            ),
            25.verticalSpace,
            Text(
              LocaleKeys.newPrice.tr(),
              style: AppTextStyles.size15Medium.copyWith(
                color: AppColors.c333333,
              ),
            ),
            5.verticalSpace,
            AppTextFormField(
              hintText: "0",
              controller: widget.priceController,
              keyBoardType: TextInputType.number,
              minLines: 1,
              maxLines: 1,
              fillColor: AppColors.cFFFFFF,
              suffixIcon: TextButton(
                onPressed: () {
                  if (currency == LocaleKeys.sum.tr()) {
                    setState(() {
                      currency = "USD";
                    });
                  } else {
                    setState(() {
                      currency = LocaleKeys.sum.tr();
                    });
                  }
                },
                child: Text(
                  currency,
                  style: AppTextStyles.size15Medium.copyWith(
                    color: AppColors.cFF9914,
                  ),
                ),
              ),
              formatters: [
                FilteringTextInputFormatter.digitsOnly,

                MoneyInputFormatter(),
              ],

              onChanged: (value) {
                final price = _parsePrice(widget.priceController.text);
                if (price == null) {
                  return;
                }
                if (price > 50000) {
                  setState(() {
                    currency = LocaleKeys.sum.tr();
                  });
                } else {
                  setState(() {
                    currency = "USD";
                  });
                }
              },
              validator: (value) {
                if (value != null) {
                  return ValidatorHelpers.validateField(value: value);
                } else {
                  return null;
                }
              },
            ),
            20.verticalSpace,
            SizedBox(
              height: 50.h,
              child: AppButton(
                width: 100.sw,
                isLoading: widget.isLoading,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onPressedSend();
                  }
                },
                text: LocaleKeys.send.tr(),
                color: AppColors.c2E3A59,
              ),
            ),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}
