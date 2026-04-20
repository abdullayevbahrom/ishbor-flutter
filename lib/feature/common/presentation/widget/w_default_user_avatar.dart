import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';

class WDefaultUserAvatar extends StatelessWidget {
  const WDefaultUserAvatar({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        width: height,
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.cE0E5EB),
          child: SvgPicture.asset(AppSvg.icUser).paddingAll(height/3.3),
        ),
      ),
    );
  }
}
