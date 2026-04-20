import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/profile/presentation/pages/payment_page/payment_page.dart';

class WVacancySalaryForm extends StatelessWidget {
  const WVacancySalaryForm({
    super.key,
    required this.salaryIsNegotiable,
    required this.checkButtonTapped,
    required this.minSalaryController,
    required this.maxSalaryController,
    required this.skillsController,
    required this.minSalaryKey,
    required this.maxSalaryKey,
    required this.currency,
    required this.onTapCurrency,
  });

  final bool salaryIsNegotiable;
  final VoidCallback checkButtonTapped;
  final VoidCallback onTapCurrency;
  final TextEditingController minSalaryController;
  final TextEditingController maxSalaryController;
  final TextEditingController skillsController;
  final Key minSalaryKey;
  final Key maxSalaryKey;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.suggestedSalary.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          15.verticalSpace,
          WCheckedBoxListTile(
            value: salaryIsNegotiable,
            title: LocaleKeys.salaryIsNegotiable.tr(),
            onTap: checkButtonTapped,
          ),
          if (!salaryIsNegotiable)
            Column(
              spacing: 4.h,
              children: [
                AppTextFormField(
                  fieldKey: minSalaryKey,
                  keyBoardType: TextInputType.number,
                  hintText: LocaleKeys.from.tr(),
                  controller: minSalaryController,
                  maxLines: 1,
                  minLines: 1,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    MoneyInputFormatter(),
                  ],
                  suffixIcon: SalarySuffixIcon(onTapCurrency: onTapCurrency, currency: currency),
                  validator: (value) {
                    return ValidatorHelpers.validateField(value: value!);
                  },
                ),
                AppTextFormField(
                  fieldKey: maxSalaryKey,
                  keyBoardType: TextInputType.number,
                  hintText: LocaleKeys.to.tr(),
                  controller: maxSalaryController,
                  maxLines: 1,
                  minLines: 1,
                  formatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    MoneyInputFormatter(),
                  ],
                  suffixIcon: SalarySuffixIcon(onTapCurrency: onTapCurrency, currency: currency),
                  validator: (value) {
                    return ValidatorHelpers.validateField(value: value!);
                  },
                ),
              ],
            ).paddingOnly(top: 10.h),
          24.verticalSpace,
          Text(
            LocaleKeys.skills.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            minLines: 5,
            hintText: LocaleKeys.enterMainSkills.tr(),
            controller: skillsController,
            keyBoardType: TextInputType.text,
          ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}

class SalarySuffixIcon extends StatelessWidget {
  const SalarySuffixIcon({
    super.key,
    required this.onTapCurrency,
    required this.currency,
  });

  final VoidCallback onTapCurrency;
  final String currency;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTapCurrency,
      child: Text(
        currency,
        style: AppTextStyles.size17Medium.copyWith(
          color: AppColors.cFF9914,
        ),
      ),
    );
  }
}
