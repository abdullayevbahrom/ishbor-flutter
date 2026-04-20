import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/edit_profile.dart';

class WVacancyPhotos extends StatelessWidget {
  const WVacancyPhotos({
    super.key,
    required this.onPressedAdd,
    required this.files,
    required this.onTapRemove,
  });

  final VoidCallback onPressedAdd;
  final List<File> files;
  final Function(int index) onTapRemove;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        spacing: 16.w,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.photos.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),

          if (files.isNotEmpty)
            WImagesPreView(files: files, removeImage: onTapRemove),

          if (files.length < 4)
            SizedBox(
              height: 45.h,
              child: AppButton(
                isAvailable: files.length < 4,
                onPressed: onPressedAdd,
                width: 100.sw,
                radius: 12.r,
                leftIcon: SizedBox(
                  height: 24.r,
                  width: 24.r,
                  child: SvgPicture.asset(AppSvg.icAddLight).paddingAll(4.r),
                ).paddingOnly(right: 5.w),
                text: LocaleKeys.addPicture.tr(),
                color: AppColors.c15CF74,
              ),
            ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
