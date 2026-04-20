import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';

class WAdsAddress extends StatelessWidget {
  const WAdsAddress({
    super.key,
    required this.address,
    required this.onPressedMap,
    required this.addressKey,
    required this.title,
    required this.city,
  });

  final String address;
  final VoidCallback onPressedMap;
  final Key addressKey;
  final String title;
  final String city;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.address.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          19.verticalSpace,
          Text(
            title,
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          8.verticalSpace,
          FormField(
            key: addressKey,
            enabled: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (address.isEmpty||city.isEmpty) {
                return LocaleKeys.addressIsRequired.tr();
              }
              return null;
            },
            builder: (field) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: onPressedMap,
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          height: 140.h,
                          width: 100.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              image: AssetImage(AppPng.imgLocationView),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      if (address.isNotEmpty && city.isNotEmpty)
                        Positioned(
                          left: 10,
                          right: 10,
                          bottom: 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: SizedBox(
                                width: 100.sw,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.cFFFFFF.newWithOpacity(.7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$city, $address',
                                      style: AppTextStyles.size12Medium
                                          .copyWith(color: AppColors.c2E3A59),
                                    ).paddingSymmetric(vertical: 10.h),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (field.hasError)
                    Text(
                      LocaleKeys.addressIsRequired.tr(),
                      style: AppTextStyles.size14Medium.copyWith(
                        color: AppColors.cRed,
                      ),
                    ).paddingOnly(left: 10.w, top: 8.h),
                ],
              );
            },
          ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
