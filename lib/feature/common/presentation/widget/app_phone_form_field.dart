import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_svg.dart';

import '../../../../core/helpers/formatters.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AppPhoneNumberTextFormField extends StatelessWidget {
  const AppPhoneNumberTextFormField({
    super.key,
    required this.phoneNumber,
    this.enableValidator = true,
  });

  final TextEditingController phoneNumber;
  final bool enableValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      controller: phoneNumber,
      style: AppTextStyles.size17Medium.copyWith(color: AppColors.c333333),
      keyboardType: TextInputType.phone,
      inputFormatters: [Formatters.phoneFormatter],
      decoration: InputDecoration(
        filled: true,
        hintText: "-- --- -- --",
       contentPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 20.w),
        suffixIconConstraints: BoxConstraints(minHeight: 50.h, maxHeight: 50.h),
        prefixIconConstraints: BoxConstraints(
          minWidth: 0,
          minHeight: 50.h,
          maxHeight: 50.h,
        ),

        prefix: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppSvg.icPhone,

            ).paddingOnly(left: 3.w, right: 14.w),
            Text(
              "+998  ",
              style: AppTextStyles.size17Medium.copyWith(
                color: AppColors.c333333,
              ),
            ),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        if (value != null && enableValidator) {
          return ValidatorHelpers.validatePhone(value: value);
        }
        return null;
      },
    );
  }
}
