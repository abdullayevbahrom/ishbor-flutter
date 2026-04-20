import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';

import '../../../../../common/presentation/widget/w_dialog_action_button.dart';


class WSalaryFilterDialog extends StatefulWidget {
  final TextEditingController salaryMinController;
  final TextEditingController salaryMaxController;

  const WSalaryFilterDialog({
    super.key,
    required this.salaryMinController,
    required this.salaryMaxController,
  });

  show(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      useRootNavigator: false,
      builder:
          (context) => this.paddingSymmetric(vertical: 250.h, horizontal: 20.w),
    );
  }

  @override
  State<WSalaryFilterDialog> createState() => _WSalaryFilterDialogState();
}

class _WSalaryFilterDialogState extends State<WSalaryFilterDialog> {
  late String currency;

  @override
  void initState() {
    currency = "USD";
    super.initState();
  }

  void updateCurrency() {
    if (currency == 'USD') {
      setState(() {
        currency = "UZS";
      });
    } else {
      setState(() {
        currency = "USD";
      });
    }
  }

  void checkUpdateCurrency() {
    final salaryMin = int.tryParse(
      widget.salaryMinController.text.trim().replaceAll(RegExp(r'[^\d]'), ''),
    );
    final salaryMax = int.tryParse(
      widget.salaryMaxController.text.trim().replaceAll(RegExp(r'[^\d]'), ''),
    );

    if (salaryMax != null && salaryMin != null) return;
    if ((salaryMin ?? 0) > 50000 || (salaryMax ?? 0) > 50000) {
      setState(() {
        currency = "UZS";
      });
    } else {
      setState(() {
        currency = "USD";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Material(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                spacing: 30.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.suggestedSalary.tr(),
                    style: AppTextStyles.size18Medium,
                  ),
                  AppTextFormField(
                    maxLines: 1,
                    minLines: 1,
                    hintText: LocaleKeys.from.tr(),
                    controller: widget.salaryMinController,
                    fillColor: AppColors.cFFFFFF,
                    keyBoardType: TextInputType.number,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      widget.salaryMinController.text = Formatters.moneyFormat(
                        widget.salaryMinController.text,
                      );
                      checkUpdateCurrency();
                    },
                    suffixIcon: TextButton(
                      onPressed: () {
                        updateCurrency();
                      },
                      child: Text(
                        currency,
                        style: AppTextStyles.size20Bold.copyWith(
                          color: AppColors.cFF9914,
                        ),
                      ),
                    ),
                  ),
                  AppTextFormField(
                    maxLines: 1,
                    minLines: 1,
                    hintText: LocaleKeys.to.tr(),
                    controller: widget.salaryMaxController,
                    fillColor: AppColors.cFFFFFF,
                    keyBoardType: TextInputType.number,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      widget.salaryMaxController.text = Formatters.moneyFormat(
                        widget.salaryMaxController.text,
                      );
                      checkUpdateCurrency();
                      setState(() {
                        Formatters.moneyFormat(widget.salaryMaxController.text);
                      });
                    },
                    suffixIcon: TextButton(
                      onPressed: () {
                        updateCurrency();
                      },
                      child: Text(
                        currency,
                        style: AppTextStyles.size20Bold.copyWith(
                          color: AppColors.cFF9914,
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingAll(16.r),
            ),
            AppDivider(width: 100.sw, height: 1.h),
            Row(
              children: [
                WDialogActionButton(
                  onTap: () {
                    widget.salaryMinController.clear();
                    widget.salaryMaxController.clear();
                    context.pop();
                  },
                  title: LocaleKeys.cancel.tr(),
                  isEnable: true,
                ),
                AppDivider(width: 1.w, height: 55.h),
                WDialogActionButton(
                  onTap: () {
                    context.pop();
                  },
                  title: LocaleKeys.save.tr(),
                  isEnable: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
