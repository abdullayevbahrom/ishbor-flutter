import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.textStyle,
    this.radius,
    this.verticalPadding,
    this.horizontalPadding,
    this.borderColor,
    this.width,
    this.isLoading,
    this.isAvailable,
    this.loadingWidget,
    this.shadow,
    this.leftIcon,
    this.rightIcon,
  });

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final bool? isLoading;
  final bool? isAvailable;
  final TextStyle? textStyle;
  final double? radius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final Color? borderColor;
  final double? width;
  final Widget? loadingWidget;
  final List<BoxShadow>? shadow;
  final Widget? leftIcon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: shadow,
          borderRadius: BorderRadius.circular(radius ?? 12.r),
        ),
        child: FilledButton(
          onPressed:
              isLoading ?? false
                  ? null
                  : isAvailable ?? true
                  ? onPressed
                  : null,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shadowColor: WidgetStatePropertyAll(
              AppColors.c15CF74.withOpacity(.4),
            ),
            side: WidgetStatePropertyAll(
              borderColor != null
                  ? BorderSide(color: AppColors.cE0E5EB, width: width ?? 0)
                  : BorderSide.none,
            ),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 12.r),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(color),
            foregroundColor: WidgetStatePropertyAll(AppColors.cMainBg),
            surfaceTintColor: WidgetStatePropertyAll(AppColors.cMainBg),
          ),
          child:
              isLoading ?? false
                  ? loadingWidget ??
                      Center(
                        child: WLoadingLottie(),
                      ).paddingSymmetric(vertical: verticalPadding ?? 10.h)
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (leftIcon != null) leftIcon!,
                      Text(
                        text,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        textScaleFactor: 1,
                        style:
                            textStyle ??
                            AppTextStyles.size17Medium.copyWith(
                              color: AppColors.cFFFFFF,
                            ),
                      ),
                      if (rightIcon != null) rightIcon!,
                    ],
                  ).paddingSymmetric(
                    vertical: verticalPadding ?? 10.h,
                    horizontal: horizontalPadding ?? 24.w,
                  ),
        ),
      ),
    );
  }
}
