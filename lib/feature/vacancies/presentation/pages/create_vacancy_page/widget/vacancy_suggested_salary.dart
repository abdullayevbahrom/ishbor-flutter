import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';

import '../../../../../common/presentation/widget/app_text_form_field.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';
import '../../../../../common/presentation/widget/w_title_with_text_form.dart';

class VacancySuggestedSalary extends StatelessWidget {
  const VacancySuggestedSalary({
    super.key,
    required this.maxSalaryController,
    required this.minSalaryController,
    required this.keySkillsController,
    required this.companyDescriptionController,
    required this.salaryInInterview,
    required this.onTapSalary,
    required this.onPressedSuffixIcon,
    required this.currencyValue, this.salaryMinKey, this.salaryMaxKey, this.skillsKey,
  });

  final TextEditingController maxSalaryController;
  final TextEditingController minSalaryController;
  final TextEditingController keySkillsController;
  final TextEditingController companyDescriptionController;
  final bool salaryInInterview;
  final VoidCallback onTapSalary;
  final VoidCallback onPressedSuffixIcon;
  final bool currencyValue;
  final Key? salaryMinKey;
  final Key? salaryMaxKey;
  final Key? skillsKey;


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
          AppUtils.hSizedBox16,
          WCheckedBoxListTile(
            value: salaryInInterview,
            title: LocaleKeys.negotiableBasedOnConversation.tr(),
            onTap: onTapSalary,
          ),
          AppUtils.hSizedBox8,

          salaryInInterview
              ? AppUtils.kSizedBoxShrink
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextFormField(
                    fieldKey: salaryMinKey,
                    maxLines: 1,
                    minLines: 1,
                    fillColor: AppColors.cFFFFFF,
                    hintText: LocaleKeys.from.tr(),
                    controller: minSalaryController,
                    keyBoardType: TextInputType.number,
                    onChanged: (value) {
                      minSalaryController.text = Formatters.moneyFormat(
                        value,
                      );
                      onPressedSuffixIcon();

                    },
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    suffixIcon: SalarySuffixIcon(
                      onPressed: onPressedSuffixIcon,
                      currencyValue: currencyValue,
                    ),
                    validator: (value) {
                      return ValidatorHelpers.validateField(
                        value: value!,
                      );
                    },
                  ),
                  AppUtils.hSizedBox4,
                  AppTextFormField(
                    fieldKey: salaryMaxKey,
                    maxLines: 1,
                    minLines: 1,
                    fillColor: AppColors.cFFFFFF,
                    hintText: LocaleKeys.to.tr(),
                    controller: maxSalaryController,
                    keyBoardType: TextInputType.number,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    suffixIcon: SalarySuffixIcon(
                      onPressed: onPressedSuffixIcon,
                      currencyValue: currencyValue,
                    ),
                    onChanged: (value) {
                      maxSalaryController.text = Formatters.moneyFormat(
                        value,
                      );
                      onPressedSuffixIcon();

                    },
                    validator: (value) {
                      return ValidatorHelpers.validateField(
                        value: value!,
                      );
                    },
                  ),
                ],
              ),

          AppUtils.hSizedBox16,
          WTitleWithTextForm(
            fieldKey: skillsKey,
            minLines: 3,
            maxLines: 10,
            textEditingController: keySkillsController,
            keyBoardType: TextInputType.text,
            title: LocaleKeys.keySkills.tr(),
            hintText: LocaleKeys.enterSkills.tr(),

          ),
          AppUtils.hSizedBox8,
          Text(
            LocaleKeys.plsIndicateKeyQualities.tr(),
            style: AppTextStyles.size13Medium.copyWith(
              color: AppColors.cBDC0C6,
            ),
          ),
          AppUtils.hSizedBox16,
        ],
      ).paddingAll(16.r),
    );
  }
}

class SalarySuffixIcon extends StatelessWidget {
  const SalarySuffixIcon({
    super.key,
    required this.onPressed,
    required this.currencyValue,
  });

  final VoidCallback onPressed;
  final bool currencyValue;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      icon: Text(
        currencyValue ? LocaleKeys.sum.tr() : "USD",
        style: AppTextStyles.size17Bold.copyWith(color: AppColors.cFF9914),
      ),
    );
  }
}
