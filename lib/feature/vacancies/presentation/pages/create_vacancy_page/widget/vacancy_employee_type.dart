import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';
import '../../../../../common/presentation/widget/w_radio_list_tile.dart';

class VacancyEmployeeType extends StatelessWidget {
  VacancyEmployeeType({
    super.key,
    required this.set,
    required this.onTap,
    required this.startTimeController,
    required this.onTapStartTime,
    required this.endTimeController,
    required this.onTapEndTime,
    this.employmentTypeKey,
  });

  final int? set;
  final Function(int index) onTap;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final VoidCallback onTapStartTime;
  final VoidCallback onTapEndTime;
  final Key? employmentTypeKey;
  final List<String> employeeTypes = [
    LocaleKeys.fullTime.tr(),
    LocaleKeys.halfTime.tr(),
    LocaleKeys.internShip.tr(),
    LocaleKeys.otheR.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.employmentType.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          FormField(
            key: employmentTypeKey,
            validator: (value) {
              if (set == null) {
                return LocaleKeys.employmentTypeCanNotBeEmpty.tr();
              }
              return null;
            },
            builder:
                (formState) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: employeeTypes.length,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.w,
                        childAspectRatio: 5,
                      ),

                      itemBuilder: (context, index) {
                        return WRadioListTile(
                          value: set == index,
                          title: employeeTypes[index],
                          onTap: () {
                            onTap(index);
                          },
                        );
                      },
                    ),
                    AppUtils.hSizedBox8,
                    if (formState.hasError ?? false)
                      Text(
                        formState.errorText ?? "",
                        style: AppTextStyles.size13Medium.copyWith(
                          color: AppColors.cRed,
                        ),
                      ),
                  ],
                ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.hSizedBox24,
              RichText(
                text: TextSpan(
                  text: LocaleKeys.enterBusinessHour.tr(),
                  style: AppTextStyles.size15Medium.copyWith(
                    color: AppColors.c333333,
                  ),
                  children: [
                    TextSpan(
                      text: " (${LocaleKeys.optional.tr()})",
                      style: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.cBDC0C6,
                      ),
                    ),
                  ],
                ),
              ),

              AppUtils.hSizedBox8,
              Row(
                spacing: 10.w,
                children: [
                  Expanded(
                    child: AppTextFormField(
                      fillColor: AppColors.cFBFBFD,
                      hintText: LocaleKeys.from.tr(),
                      controller: startTimeController,
                      onTap: onTapStartTime,
                      //suffixIcon: Icon(Icons.watch_later,color: AppColors.cBDC0C6,),
                      keyBoardType: TextInputType.none,
                      // validator: (value) {
                      //   return ValidatorHelpers.validateField(value: value!);
                      // },
                    ),
                  ),
                  Expanded(
                    child: AppTextFormField(
                      fillColor: AppColors.cFBFBFD,
                      hintText: LocaleKeys.to.tr(),
                      controller: endTimeController,
                      onTap: onTapEndTime,
                      //suffixIcon: Icon(Icons.watch_later,color: AppColors.cBDC0C6,),
                      keyBoardType: TextInputType.none,
                      // validator: (value) {
                      //   return ValidatorHelpers.validateField(value: value!);
                      // },
                    ),
                  ),
                ],
              ),
            ],
          ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: employeeTypes.length,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return WRadioListTile(
          //       value: set.contains(index),
          //       title: employeeTypes[index],
          //       onTap: () {
          //         onTap(index);
          //       },
          //     );
          //   },
          // ),
        ],
      ).paddingAll(16.r),
    );
  }
}
