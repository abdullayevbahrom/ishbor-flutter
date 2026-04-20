import 'package:flutter/material.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_check_box_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';

class WVacancyWhoCanRespondForm extends StatelessWidget {
  const WVacancyWhoCanRespondForm({
    super.key,
    required this.withFullResume,
    required this.enablePartTime,
    required this.onTappedResume,
    required this.onTappedEmpType,
  });

  final bool withFullResume;
  final bool enablePartTime;
  final VoidCallback onTappedResume;
  final VoidCallback onTappedEmpType;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        spacing: 16.h,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.whoCanRespond.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          WCheckedBoxListTile(
            value: withFullResume,
            title: LocaleKeys.applicantWithoutProfile.tr(),
            onTap: onTappedResume,
          ),
          16.verticalSpace,
          Text(
            LocaleKeys.additional.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          WCheckedBoxListTile(
            value: enablePartTime,
            title: LocaleKeys.temporaryEmploymentPossible.tr(),
            onTap: onTappedEmpType,
          ),
          20.verticalSpace,
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
