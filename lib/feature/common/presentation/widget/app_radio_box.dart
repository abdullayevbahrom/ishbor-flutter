import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AppRadioBox extends StatelessWidget {
  const AppRadioBox({super.key, required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.r,
      width: 18.r,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(36.r),
          border: Border.all(
            color: value ? AppColors.c1DBA6E : AppColors.cE0E5EB,
            width: value ? 5.r : 2.r,
          ),
        ),
      ),
    );
  }
}
