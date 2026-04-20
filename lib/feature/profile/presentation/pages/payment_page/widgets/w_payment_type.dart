import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_lottie.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';

final List<String> _paymentTypes = [
  AppSvg.icClick,
  AppSvg.icPayme,
  // AppSvg.icUzum,
  // AppSvg.icPaynet,
  // AppSvg.icAlif,
  // AppSvg.icCash,
];

class WPaymentTypes extends StatelessWidget {
  const WPaymentTypes({
    super.key,
    required this.onPressedPaymentType,
    required this.currentIndex,
  });

  final Function(int index) onPressedPaymentType;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return FormField(
      enabled: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return currentIndex == -1 ? LocaleKeys.pleaseTypeToSearch : null;
      },
      builder: (field) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _paymentTypes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.r,
                crossAxisSpacing: 10.r,
                // childAspectRatio: 120 / 80,
                mainAxisExtent: 80,
              ),
              itemBuilder: (context, index) {
                return WPaymentTypeItem(
                  onPressed: () {
                    if (index == 0 || index == 1) {
                      onPressedPaymentType(index);
                    } else {
                      showErrorDialog(
                        title: LocaleKeys.paymentMethodUnavailable.tr(),
                        body: LocaleKeys.thisUnavailableTechnicalMaintance.tr(),
                        lottiePath: AppLottie.warning
                      );
                    }
                  },
                  svgIcon: _paymentTypes[index],
                  isActive: currentIndex == index,
                );
              },
            ),
            if (field.hasError)
              Text(
               LocaleKeys.selectPaymentType.tr(),
                style: Theme.of(context).inputDecorationTheme.errorStyle,
              ).paddingOnly(top: 5.h, left:16.w),
          ],
        ).paddingSymmetric(horizontal: 16.w);
      },
    );
  }
}

class WPaymentTypeItem extends StatelessWidget {
  const WPaymentTypeItem({
    super.key,
    required this.svgIcon,
    required this.isActive,
    required this.onPressed,
  });

  final String svgIcon;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.r),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isActive ? AppColors.cFF9914.newWithOpacity(.3) : AppColors.cF7F9FC,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgIcon),
            // if (svgIcon == _paymentTypes.last)
            //   Text(
            //     LocaleKeys.cash.tr(),
            //     style: AppTextStyles.size14Medium.copyWith(
            //       color: isActive ? AppColors.cFFFFFF : AppColors.c2E3A59,
            //     ),
            //   ).paddingOnly(top: 7.h),
          ],
        ),
      ),
    );
  }
}
