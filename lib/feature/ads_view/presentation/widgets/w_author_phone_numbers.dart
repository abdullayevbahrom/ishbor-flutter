import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/helpers/app_launcher.dart';
import '../../../../core/helpers/formatters.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../common/data/models/contact_click_params.dart';
import '../../../common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';

class WAuthorPhoneNumbers extends StatelessWidget {
  const WAuthorPhoneNumbers({
    super.key,
    required this.phoneNumbers,
    required this.type,
    required this.id,
  });

  final List<String?> phoneNumbers;
  final String type;
  final int id;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Material(
          child: Wrap(children: [this]),
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          11.verticalSpace,
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 5.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.cE0E5EB,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          24.verticalSpace,
          Text(
            LocaleKeys.contactPhoneNumber.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ).paddingSymmetric(horizontal: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(phoneNumbers.length, (index) {
              return ValidatorHelpers.validatePhoneNumber(phoneNumbers[index])
                  ? ListTile(
                enabled: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                onTap: () {
                  context.read<AskQuestionCubit>().addContactClick(
                    params: ContactClickParams(
                      id: id,
                      type: type,
                      contact: "${phoneNumbers[index]}",
                    ),
                  );
                  AppLauncher().launchPhoneNumber(
                    Formatters.formatAuthorPhone(phoneNumbers[index] ?? ''),
                  );
                },
                leading: SvgPicture.asset(AppSvg.icPhone),
                title: Text(
                  Formatters.formatAuthorPhone(phoneNumbers[index] ?? ''),
                ),
              )
                  : SizedBox.shrink();
            }),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
