import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/app_phone_form_field.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class WInquiryPhoneNumbers extends StatefulWidget {
  const WInquiryPhoneNumbers({
    super.key,
    required this.phoneNumberController,
    required this.phoneNumberController1,
    required this.phoneNumberController2,
    required this.phoneNumberController3,
  });

  final TextEditingController phoneNumberController;
  final TextEditingController phoneNumberController1;
  final TextEditingController phoneNumberController2;
  final TextEditingController phoneNumberController3;

  @override
  State<WInquiryPhoneNumbers> createState() => _WInquiryPhoneNumbersState();
}

class _WInquiryPhoneNumbersState extends State<WInquiryPhoneNumbers> {
  final user = navigatorKey.currentContext?.read<UserCubit>().state.user;
  int currentIndex = 1;

  // late TextEditingController phoneNumberController;
  // late TextEditingController phoneNumberController1;
  // late TextEditingController phoneNumberController2;
  // late TextEditingController phoneNumberController3;

  @override
  void initState() {
    if (user?.phoneNumber != null) {
      widget.phoneNumberController.text = Formatters.formatUzbekPhone(
        user!.phoneNumber!.substring(
          user!.phoneNumber!.length - 9,
          user!.phoneNumber!.length,
        ),
      );
    }

    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.phoneNumberController.dispose();
  //   widget.phoneNumberController1.dispose();
  //   widget.phoneNumberController2.dispose();
  //   widget.phoneNumberController3.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        spacing: 20.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            LocaleKeys.inquiryPhoneNumber.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          Row(
            spacing: 10.w,
            children: [
              Flexible(
                child: AppPhoneNumberTextFormField(
                  phoneNumber: widget.phoneNumberController,
                ),
              ),

              if (currentIndex == 1) addPhoneNumber(),
            ],
          ),
          if (currentIndex >= 2)
            Row(
              spacing: 10.w,
              children: [
                Flexible(
                  child: AppPhoneNumberTextFormField(
                    phoneNumber: widget.phoneNumberController1,
                    enableValidator:
                        widget.phoneNumberController1.text.trim().isNotEmpty,
                  ),
                ),
                if (currentIndex == 2) addPhoneNumber(),
              ],
            ),
          if (currentIndex >= 3)
            Row(
              spacing: 10.w,
              children: [
                Flexible(
                  child: AppPhoneNumberTextFormField(
                    phoneNumber: widget.phoneNumberController2,
                    enableValidator:
                        widget.phoneNumberController2.text.trim().isNotEmpty,
                  ),
                ),
                if (currentIndex == 3) addPhoneNumber(),
              ],
            ),
          if (currentIndex >= 4)
            Row(
              spacing: 10.w,
              children: [
                Flexible(
                  child: AppPhoneNumberTextFormField(
                    phoneNumber: widget.phoneNumberController3,
                    enableValidator:
                        widget.phoneNumberController3.text.trim().isNotEmpty,
                  ),
                ),
                if (currentIndex == 4) addPhoneNumber(),
              ],
            ),
        ],
      ).paddingAll(16.r),
    );
  }

  SizedBox addPhoneNumber() {
    return SizedBox(
      height: 50.h,
      width: 50.h,
      child: AppButton(
        horizontalPadding: 0,
        onPressed: () {
          setState(() {
            currentIndex++;
          });
        },
        isAvailable: currentIndex <= 3,
        text: '',
        color:
            currentIndex <= 3
                ? AppColors.c15CF74
                : AppColors.c15CF74.newWithOpacity(.3),
        leftIcon: Icon(Icons.add, size: 20.r, color: AppColors.cFFFFFF),
      ),
    );
  }
}
