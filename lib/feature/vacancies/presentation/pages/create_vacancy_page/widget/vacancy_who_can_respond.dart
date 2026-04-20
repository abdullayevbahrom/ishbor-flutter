import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';
import '../../../../../common/presentation/widget/w_title_with_text_form.dart';

class VacancyWhoCanRespond extends StatelessWidget {
  const VacancyWhoCanRespond({
    super.key,
    required this.isApplicationAvailable,
    required this.isTemporaryAvailable,
    required this.onTapApplication,
    required this.onTapTemporary,
    required this.companyDescriptionController,
  });

  final bool isApplicationAvailable;
  final bool isTemporaryAvailable;
  final VoidCallback onTapApplication;
  final VoidCallback onTapTemporary;
  final TextEditingController companyDescriptionController;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            LocaleKeys.whoCanRespond.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          AppUtils.hSizedBox16,
          WCheckedBoxListTile(
            value: isApplicationAvailable,
            title: LocaleKeys.applicantWithoutACompleteResume.tr(),
            onTap: onTapApplication,
          ),
          AppUtils.hSizedBox32,
          ExpansionTile(
            shape: Border(),
            tilePadding: EdgeInsets.zero,
            childrenPadding: EdgeInsets.zero,
            collapsedBackgroundColor: AppColors.cTransparent,
            iconColor: AppColors.cFF9914,
            collapsedIconColor: AppColors.cFF9914,
            internalAddSemanticForOnTap: false,
            dense: false,
            title: Text(
              LocaleKeys.additional.tr(),
              style: AppTextStyles.size22Bold.copyWith(
                color: AppColors.c333333,
              ),
            ),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: WCheckedBoxListTile(
                  value: isTemporaryAvailable,
                  title: LocaleKeys.temporaryEmploymentIsPossible.tr(),
                  onTap: onTapTemporary,
                ),
              ),
              AppUtils.hSizedBox16,
              WTitleWithTextForm(
                minLines: 3,
                maxLines: 10,
                textEditingController: companyDescriptionController,
                keyBoardType: TextInputType.text,
                title: LocaleKeys.descriptionOfCompany.tr(),
                richText: " (${LocaleKeys.optional.tr()})",
                hintText: LocaleKeys.enterDescription.tr(),
              ),
              AppUtils.hSizedBox8,
              Text(
                LocaleKeys.usePostingAnonymousVacancies.tr(),
                style: AppTextStyles.size13Medium.copyWith(
                  color: AppColors.cBDC0C6,
                ),
              ),
            ],
          ),
        ],
      ).paddingAll(16.r),
    );
  }
}
