import 'package:flutter/material.dart';
import 'package:top_jobs/export.dart';

import 'app_check_box.dart';

class WCheckedBoxListTile extends StatelessWidget {
  final bool value;
  final String title;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const WCheckedBoxListTile({
    super.key,
    required this.value,
    required this.title,
    required this.onTap, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 13.w,
        children: [
          AppCheckBox(
            value: value,
            onChanged: (value) {
              onTap();
            },
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              title,
              maxLines: 10,
              style:textStyle?? AppTextStyles.size15Regular.copyWith(color: AppColors.c222222),
            ),
          ),
        ],
      ).paddingSymmetric(vertical: 4.h),
    );
  }
}

/*
ListTile(
      onTap: onTap,
      enabled: true,
      splashColor: AppColors.cFF9914.withOpacity(.1),
      trailing: null,
      minVerticalPadding:0 ,
      style: ListTileStyle.drawer,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      leading: AppCheckBox(
          value: value, onChanged: (value) {
        onTap();
      }),
      horizontalTitleGap: 0,
      focusColor: AppColors.cFF9914,
      hoverColor: AppColors.cFF9914,
      title: Text(
        title,
        style: AppTextStyles.size15Regular.copyWith(color: AppColors.c222222),
      ),
    )
 */
