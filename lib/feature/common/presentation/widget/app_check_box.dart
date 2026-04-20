import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key, required this.value, required this.onChanged});

  final bool value;
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (value) {
        onChanged(value ?? false);
      },
      splashRadius: 0,
      visualDensity: VisualDensity(
        vertical: -4,
        horizontal: -4

      ),
      materialTapTargetSize:  MaterialTapTargetSize.shrinkWrap,
      side: BorderSide(color: AppColors.cE0E5EB),
      focusColor: AppColors.c1DBA6E,
      overlayColor: WidgetStatePropertyAll(AppColors.cFFFFFF),
      activeColor: AppColors.c1DBA6E,
      checkColor: AppColors.cFFFFFF,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.r)),
    );
  }
}
