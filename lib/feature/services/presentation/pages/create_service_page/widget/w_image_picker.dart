import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_svg.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class WImagePicker extends StatelessWidget {
  const WImagePicker({
    super.key,
    required this.onPressed,
    required this.images,
  });

  final VoidCallback onPressed;
  final List<File> images;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.photos.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          24.verticalSpace,
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.c15CF74.withOpacity(.4),
                  blurRadius: 15.r,
                  offset: const Offset(0, 4),

                )
              ]
            ),
            child: SizedBox(
              height: 45.h,
              child: MaterialButton(
                color: AppColors.c15CF74,
                onPressed: onPressed,
                height: 45.h,
                minWidth: 100.sw,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppSvg.icAddLight),
                    10.horizontalSpace,
                    Text(
                      LocaleKeys.addPicture.tr(),
                      style: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
         24.verticalSpace,
          SizedBox(
            height: 90.h,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: images.length == 0 ? 4 : images.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    SizedBox(
                      height: 70.h,
                      width: 70.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.cE0E5EB.withOpacity(.3),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child:
                            images.length > 0
                                ? Image.file(images[index], fit: BoxFit.cover)
                                : AppUtils.kSizedBoxShrink,
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   top: -0,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       color: AppColors.cFFFFFF,
                    //       borderRadius: BorderRadius.circular(25.r),
                    //     ),
                    //     child: Icon(
                    //       Icons.cancel,
                    //       color: AppColors.c000000,
                    //       size: 20,
                    //     ),
                    //   ),
                    // ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return AppUtils.wSizedBox16;
              },
            ),
          ),
        ],
      ).paddingAll(16.r),
    );
  }
}
