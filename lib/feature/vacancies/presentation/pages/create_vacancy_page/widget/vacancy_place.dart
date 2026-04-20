import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/export.dart';
import 'package:yandex_geocoder/yandex_geocoder.dart';

import '../../../../../../core/helpers/string_helpers.dart';
import '../../../../../../core/theme/app_png.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../common/presentation/widget/w_decorated_box.dart';
import '../../../cubits/create_vacancy_cubit/create_vacancy_cubit.dart';

class VacancyPlace extends StatelessWidget {
  const VacancyPlace({
    super.key,
    required this.vacancyLocationController,
    required this.onLocationSelected,
    required this.cityController,
    this.cityKey,
    this.locKey,
  });

  final TextEditingController vacancyLocationController;
  final TextEditingController cityController;
  final Function(GeocodeResponse address) onLocationSelected;
  final Key? cityKey;
  final Key? locKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateVacancyCubit, CreateVacancyState>(
      builder: (context, state) {
        return WDecoratedBox(
          radius: 16.r,
          bgColor: AppColors.cFBFBFD,
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.placeOfService.tr(),
                style: AppTextStyles.size22Bold.copyWith(
                  color: AppColors.c2E3A59,
                ),
              ),

              Text(
                LocaleKeys.selectLocation.tr(),
                style: AppTextStyles.size15Medium.copyWith(
                  color: AppColors.c333333,
                ),
              ),
              FormField(
                key: locKey,
                validator: (value) {
                  if (state.location == null) {
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
                              onLocationSelected(response);
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
                        if (state.location != null)
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
                                    "${state.location?.response?.geoObjectCollection?.featureMember?[0].geoObject?.metaDataProperty?.geocoderMetaData?.text}",
                                  ),
                                  style: AppTextStyles.size15Medium.copyWith(
                                    color: AppColors.c333333,
                                  ),
                                ),
                              ),
                            ],
                          ).paddingOnly(top: 8.h, left: 8.w),
                        if (field.hasError && state.location == null)
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
      },
    );
  }
}
