import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';

class WModalSheetDecoratedContainer extends StatelessWidget {
  const WModalSheetDecoratedContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 6.h,
        width: 95.w,
        decoration: BoxDecoration(
          color: AppColors.cE0E5EB,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
