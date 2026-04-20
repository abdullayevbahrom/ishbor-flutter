import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class VacancyOperationModes extends StatelessWidget {
  final Set set;
  final Function(int index) onTap;
  List<String> operationModes = [
    LocaleKeys.workOnlyOnSatAndSun.tr(),
    LocaleKeys.canWorkShiftsOf46HoursADay.tr(),
    LocaleKeys.canStartToWorkAfter16_00.tr(),
    LocaleKeys.free.tr(),
    LocaleKeys.flexible.tr(),
  ];

  VacancyOperationModes({super.key, required this.set, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.operatingMode.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c333333),
          ),

          ListView.builder(
            shrinkWrap: true,
            itemCount: operationModes.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return WCheckedBoxListTile(
                value: set.contains(index),
                title: operationModes[index],
                onTap: () {
                  onTap(index);
                },
              );
            },
          ),
        ],
      ).paddingAll(16.r),
    );
  }
}
