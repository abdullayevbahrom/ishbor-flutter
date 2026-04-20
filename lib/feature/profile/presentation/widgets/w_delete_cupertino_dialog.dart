import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/export.dart';
class WDeleteCupertinoDialog extends StatelessWidget {
  const WDeleteCupertinoDialog({super.key, required this.onPressedYes});

  final VoidCallback onPressedYes;

  show(BuildContext context) {
    showCupertinoDialog(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        LocaleKeys.attention.tr(),
        style: AppTextStyles.size20Bold.copyWith(color: AppColors.c2E3A59),
      ),
      content: Text(
        LocaleKeys.areSureToDelete.tr(),
        style: AppTextStyles.size15Medium,
      ).paddingOnly(top: 10.h),
      actions: [
        MaterialButton(
          onPressed: onPressedYes,
          child: Text(
            LocaleKeys.yes.tr(),
            style: AppTextStyles.size15Regular.copyWith(color: AppColors.cRed),
          ),
        ),
        MaterialButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            LocaleKeys.no.tr(),
            style: AppTextStyles.size15Regular.copyWith(
              color: AppColors.c13A5E3,
            ),
          ),
        ),
      ],
    );
  }
}
