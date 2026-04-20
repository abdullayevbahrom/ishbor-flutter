import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.width, this.height, this.color});

  final double? width;
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 1.w,
      height: height ?? 18.h,
      color: color ?? AppColors.cE0E5EB,
    );
  }
}
