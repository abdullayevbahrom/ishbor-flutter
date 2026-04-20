import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_phone_form_field.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class WVacancyPhoneNumber extends StatefulWidget {
  const WVacancyPhoneNumber({
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
  State<WVacancyPhoneNumber> createState() => _WVacancyPhoneNumberState();
}

class _WVacancyPhoneNumberState extends State<WVacancyPhoneNumber> {
  int currentIndex = 0;
  VacancyFormState? _previousState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<VacancyFormCubit, VacancyFormState>(
      listenWhen: (previous, current) {
        _previousState = previous;
        return true;
      },
      listener: (context, state) {
        final hadUnpublishedAds = _previousState?.hasUnpublishedAds ?? false;
        if (state.hasUnpublishedAds && !hadUnpublishedAds) {
          if (state.params?.phoneNumber1 != null) {
            setState(() {
              currentIndex = 1;
            });
            widget.phoneNumberController1.text = Formatters.formatUzbekPhone(
              state.params!.phoneNumber1!,
            );
          }

          if (state.params?.phoneNumber2 != null) {
            setState(() {
              currentIndex = 2;
            });
            widget.phoneNumberController2.text = Formatters.formatUzbekPhone(
              state.params!.phoneNumber2!,
            );
          }
          if (state.params?.phoneNumber3 != null) {
            setState(() {
              currentIndex = 3;
            });
            widget.phoneNumberController3.text = Formatters.formatUzbekPhone(
              state.params!.phoneNumber3!,
            );
          }
        }
      },
      child: WDecoratedBox(
        radius: 16.r,
        bgColor: AppColors.cFBFBFD,
        child: Column(
          spacing: 10.h,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.inquiryPhoneNumber.tr(),
              style: AppTextStyles.size22Bold.copyWith(
                color: AppColors.c2E3A59,
              ),
            ),
            5.verticalSpace,
            Row(
              spacing: 8.w,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: AppPhoneNumberTextFormField(
                    phoneNumber: widget.phoneNumberController,
                  ),
                ),
                if (currentIndex == 0)
                  AddPhoneNumberButton(
                    onPressedBtn: () {
                      setState(() {
                        currentIndex += 1;
                      });
                    },
                  ),
              ],
            ),
            if (currentIndex >= 1)
              Row(
                spacing: 8.w,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppPhoneNumberTextFormField(
                      phoneNumber: widget.phoneNumberController1,
                      enableValidator: false,
                    ),
                  ),
                  if (currentIndex == 1)
                    AddPhoneNumberButton(
                      onPressedBtn: () {
                        setState(() {
                          currentIndex += 1;
                        });
                      },
                    ),
                ],
              ),
            if (currentIndex >= 2)
              Row(
                spacing: 8.w,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppPhoneNumberTextFormField(
                      phoneNumber: widget.phoneNumberController2,
                      enableValidator: false,
                    ),
                  ),
                  if (currentIndex == 2)
                    AddPhoneNumberButton(
                      onPressedBtn: () {
                        setState(() {
                          currentIndex += 1;
                        });
                      },
                    ),
                ],
              ),
            if (currentIndex >= 3)
              AppPhoneNumberTextFormField(
                phoneNumber: widget.phoneNumberController3,
                enableValidator: false,
              ),
          ],
        ).paddingAll(16.r),
      ),
    ).paddingSymmetric(horizontal: 16.w);
  }
}

class AddPhoneNumberButton extends StatelessWidget {
  const AddPhoneNumberButton({super.key, required this.onPressedBtn});

  final VoidCallback onPressedBtn;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        focusColor: AppColors.c15CF74,
        disabledColor: AppColors.c15CF74,
        color: AppColors.c15CF74,
        sizeStyle: CupertinoButtonSize.large,
        child: Icon(CupertinoIcons.add, color: AppColors.cFFFFFF),
        onPressed: onPressedBtn,
      ),
    );
  }
}
