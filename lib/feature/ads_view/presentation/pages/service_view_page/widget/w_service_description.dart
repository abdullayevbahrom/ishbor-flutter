import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../services/data/models/service.dart';

class WServiceDescription extends StatelessWidget {
  const WServiceDescription({super.key, required this.service});

  final ServiceModel? service;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.cE0E5EB, width: 1.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service?.description
                    ?.resolve(context.locale.languageCode)
                    ?.replaceAll("**", "") ??
                '',
            textAlign: TextAlign.start,
            style: AppTextStyles.size17Regular,
          ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}
