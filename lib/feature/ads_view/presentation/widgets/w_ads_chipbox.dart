import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';

class WAdsChipBox extends StatelessWidget {
  const WAdsChipBox({
    super.key,
    this.employmentType,
    this.temporaryWork,
    this.withFullResume,
    this.category,
  });

  final String? employmentType;
  final bool? temporaryWork;
  final bool? withFullResume;
  final String? category;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 8.w,
      runSpacing: 8.h,
      children: [
        if (employmentType != null)
          WChipBoxItem(
            text:
                employmentType == "full employment"
                    ? LocaleKeys.fullEmployment.tr()
                    : LocaleKeys.partTimeJob.tr(),
          ),
        if (temporaryWork != null)
          WChipBoxItem(
            text:
                temporaryWork ?? false
                    ? LocaleKeys.temporaryJob.tr()
                    : LocaleKeys.PermanentJob.tr(),
          ),
        if (category != null) WChipBoxItem(text: category!, isCategory: true),
        if (withFullResume != null)
          WChipBoxItem(
            text:
                withFullResume ?? false
                    ? LocaleKeys.WithOutExperience.tr()
                    : LocaleKeys.WithExperience.tr(),
          ),
      ],
    );
  }
}

class WChipBoxItem extends StatelessWidget {
  const WChipBoxItem({
    super.key,
    required this.text,
    this.isCategory = false,
    this.bgColor,
  });

  final String text;
  final bool isCategory;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color:
            bgColor != null
                ? bgColor
                : isCategory
                ? AppColors.cFF9914.newWithOpacity(.14)
                : AppColors.cF7F9FC,
      ),
      child: Text(
        text,
        style: AppTextStyles.size14Medium,
      ).paddingSymmetric(vertical: 5.h, horizontal: 13.w),
    );
  }
}
