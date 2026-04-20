import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';

import '../../../common/data/models/category.dart';

class WAdsBasicInformation extends StatelessWidget {
  const WAdsBasicInformation({
    super.key,
    required this.serviceNameController,
    required this.categoriesController,
    required this.onPressedCategories,
    required this.serviceNameKey,
    required this.categoriesKey,
    required this.categories,
  });

  final TextEditingController serviceNameController;
  final TextEditingController categoriesController;
  final VoidCallback onPressedCategories;
  final Key serviceNameKey;
  final Key categoriesKey;
  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {

    return WDecoratedBox(
      bgColor: AppColors.cFBFBFD,
      radius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.basicInformation.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          16.verticalSpace,
          Text(
            LocaleKeys.serviceName.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            fieldKey: serviceNameKey,
            hintText: LocaleKeys.enterServiceName.tr(),
            controller: serviceNameController,
            keyBoardType: TextInputType.text,
            validator: (value) {
              if (value != null) {
                return ValidatorHelpers.validateField(value: value);
              } else {
                return null;
              }
            },
          ),
          19.verticalSpace,
          Text(
            LocaleKeys.category.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          8.verticalSpace,
          AppTextFormField(
            onTap: onPressedCategories,
            fieldKey: categoriesKey,
            hintText: LocaleKeys.selectCategory.tr(),
            controller: categoriesController,
            keyBoardType: TextInputType.none,
            suffixIcon: Icon(
              Icons.keyboard_arrow_right,
              size: 24.r,
              color: AppColors.cFF9914,
            ),
            validator: (value) {
              if (value != null) {
                return ValidatorHelpers.validateField(value: value);
              } else {
                return null;
              }
            },
          ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
/*
 categoriesController.text = categories
        .map((e) {
          return e
              .translations[context.locale.languageCode == 'ru' ? 0 : 1]
              .name;
        })
        .join(',');
 */