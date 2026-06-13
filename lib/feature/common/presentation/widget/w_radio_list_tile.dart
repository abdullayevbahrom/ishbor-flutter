import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'app_radio_box.dart';

class WRadioListTile extends StatelessWidget {
  const WRadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    this.tileKey,
  });

  final String title;
  final bool value;
  final VoidCallback onTap;
  final Key? tileKey;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: tileKey,
      onTap: onTap,
      horizontalTitleGap: 4.w,
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,

      leading: Transform.scale(scale: 1.2, child: AppRadioBox(value: value)),
      title: Text(
        title,
        style: AppTextStyles.size15Regular.copyWith(color: AppColors.c222222),
      ),
    );
  }
}
