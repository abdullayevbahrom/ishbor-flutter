import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_png.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/feature/vacancies/presentation/pages/create_vacancy_page/widget/vacancy_suggested_salary.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../core/helpers/string_helpers.dart';
import '../../../../../../core/helpers/validators.dart';
import '../../../../../../core/router/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../common/presentation/widget/app_text_form_field.dart';
import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';

class SuggestedSalary extends StatelessWidget {
  const SuggestedSalary({
    super.key,
    required this.maxSalaryController,
    required this.minSalaryController,
    required this.locationController,
    required this.onTapCheckBox,
    required this.checkBoxValue,
    required this.onTapCurrency,
    required this.currencyValue,
    required this.onSelectedLocation,
    required this.onChangedCurrency,
    required this.cityController,
    this.salaryKey,
    this.cityKey,
    this.locationKey,
    this.location,
  });

  final TextEditingController maxSalaryController;
  final TextEditingController minSalaryController;
  final TextEditingController locationController;
  final TextEditingController cityController;
  final VoidCallback onTapCheckBox;
  final bool checkBoxValue;
  final VoidCallback onTapCurrency;
  final bool currencyValue;
  final Function(GeocodeResponse address) onSelectedLocation;
  final Function(String? value) onChangedCurrency;
  final Key? salaryKey;
  final Key? cityKey;
  final Key? locationKey;
  final GeocodeResponse? location;

  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.placeOfService.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          AppUtils.hSizedBox24,
          Text(
            LocaleKeys.suggestedSalary.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          if (!checkBoxValue) AppUtils.hSizedBox8,
          if (!checkBoxValue)
            AppTextFormField(
              fieldKey: salaryKey,
              keyBoardType: TextInputType.number,
              fillColor: AppColors.cFBFBFD,
              hintText: LocaleKeys.suggestedSalary.tr(),
              controller: minSalaryController,
              formatters: [FilteringTextInputFormatter.digitsOnly],
              suffixIcon: SalarySuffixIcon(
                onPressed: onTapCurrency,
                currencyValue: currencyValue,
              ),
              onChanged: (value) {
                minSalaryController.text = Formatters.moneyFormat(value);
                onChangedCurrency(value);
              },
              validator: (value) {
                return ValidatorHelpers.validateField(value: value!);
              },
            ),
          AppUtils.hSizedBox8,
          WCheckedBoxListTile(
            value: checkBoxValue,
            title: LocaleKeys.negotiable.tr(),
            onTap: onTapCheckBox,
          ),
          AppUtils.hSizedBox24,
          Text(
            LocaleKeys.selectLocation.tr(),
            style: AppTextStyles.size15Medium.copyWith(
              color: AppColors.c333333,
            ),
          ),
          AppUtils.hSizedBox8,
          FormField(
            key: locationKey,
            validator: (value) {
              if (location == null) {
                return LocaleKeys.selectLocation.tr();
              }
              return null;
            },
            builder:
                (field) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () async {
                        GeocodeResponse? response = await context.push(
                          Routes.yandexMap,
                        );
                        if (response != null) {
                          onSelectedLocation(response);
                        }
                      },
                      child: Container(
                        height: 140.h,
                        width: 100.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: AssetImage(AppPng.map),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    if (location != null)
                      Row(
                        spacing: 8.w,
                        children: [
                          SvgPicture.asset(
                            AppSvg.icLocationDefault,
                            height: 25.h,
                          ),
                          Expanded(
                            child: Text(
                              StringHelpers.extractStreet(
                                "${location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                              ),
                              style: AppTextStyles.size15Medium.copyWith(
                                color: AppColors.c333333,
                              ),
                            ),
                          ),
                        ],
                      ).paddingOnly(top: 8.h, left: 8.w),
                    if (field.hasError && location == null)
                      Text(
                        field.errorText ?? '',
                        style: AppTextStyles.size13Medium.copyWith(
                          color: AppColors.cRed,
                        ),
                      ).paddingOnly(top: 4.h, left: 8.w),
                  ],
                ),
          ),
        ],
      ).paddingAll(16.r),
    );
  }
}
