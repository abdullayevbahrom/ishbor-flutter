import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';

class WDecoratedTitle extends StatelessWidget {
  const WDecoratedTitle({super.key, required this.title, this.isBold});

  final String title;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              isBold ?? false
                  ? AppTextStyles.size15Medium.copyWith(
                    color: AppColors.c333333,
                  )
                  : AppTextStyles.size15Regular.copyWith(
                    color: AppColors.cB7BFCA,
                  ),
        ),
        isBold ?? false ? 10.verticalSpace : 5.verticalSpace,
      ],
    );
  }
}
