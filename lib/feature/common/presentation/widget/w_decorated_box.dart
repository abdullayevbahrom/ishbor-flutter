import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';

class WDecoratedBoxWithShadow extends StatelessWidget {
  const WDecoratedBoxWithShadow({
    super.key,
    required this.child,
    this.padding,
    this.bgColor,
  });

  final Widget child;
  final double? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 40,
            color: AppColors.c000000.withOpacity(.05),
          ),
        ],
      ),
      child: child.paddingSymmetric(horizontal: 22.w, vertical: 18.h),
    );
  }
}

class WDecoratedBox extends StatelessWidget {
  const WDecoratedBox({
    super.key,
    required this.child,
    this.radius,
    this.bgColor,
  });

  final Widget child;
  final double? radius;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.sw,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(radius ?? 8.r),
        ),
        child: child,
      ),
    );
  }
}
