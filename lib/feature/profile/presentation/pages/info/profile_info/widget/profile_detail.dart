import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_cached_network_image.dart';

import '../../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../../core/helpers/formatters.dart';
import '../../../../../../../core/theme/app_colors.dart';
import '../../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../common/presentation/cubits/user_cubit/user_cubit.dart'
    show UserCubit, UserState;

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final user = state.user;
        return Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailsRow(
              label: LocaleKeys.phoneNumber.tr() + ":",
              value: Formatters.formatUzbekPhoneNumber(
                user?.phoneNumber ?? '-',
              ),
            ),
            _DetailsRow(
              label: LocaleKeys.email.tr() + ":",
              value: user?.email ?? '-',
            ),
            _DetailsRow(
              label: LocaleKeys.birthDate.tr() + ":",
              value:
                  user?.birthDay != null
                      ? Formatters.formatDateBirthday(user!.birthDay!)
                      : "-",
            ),
            _DetailsRow(
              label: LocaleKeys.gender.tr() + ":",
              value:
                  user?.gender != null
                      ? user?.gender == 'male'
                          ? LocaleKeys.Male.tr()
                          : LocaleKeys.Female.tr()
                      : '-',
            ),
            _DetailsRow(
              label: LocaleKeys.city.tr() + ":",
              value: user?.city ?? '-',
            ),
            _DetailsRow(
              label: LocaleKeys.categories.tr(),
              value:
                  user?.categories != null && user?.categories?.length != 0
                      ? user?.categories
                              ?.map(
                                (e) =>
                                    e
                                        .translations[context.locale == 'ru'
                                            ? 0
                                            : 1]
                                        .name,
                              )
                              .join(',') ??
                          ''
                      : "-",
              textStyle: AppTextStyles.size17Regular.copyWith(
                color: AppColors.cFF9914,
              ),
            ),
            _DetailsRow(
              label: LocaleKeys.description.tr(),
              value: user?.aboutMe ?? '-',
            ),
            if ((user?.portfolios?.length ?? 0) > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.jobExamples.tr(),
                    style: AppTextStyles.size17Medium.copyWith(
                      color: AppColors.c888888,
                    ),
                  ).paddingSymmetric(horizontal: 16.w),
                  SizedBox(
                    height: 70.r,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: user?.portfolios?.length ?? 0,
                      padding: EdgeInsets.only(top: 8.h, left: 16.w),
                      separatorBuilder:
                          (context, index) => AppUtils.wSizedBox16,
                      itemBuilder: (context, index) {
                        return AppCachedNetworkImage(
                          height: 70.r,
                          width: 70.r,
                          radius: 8.r,
                          imageUrl: user?.portfolios?[index].urls['original'],
                        );
                      },
                    ),
                  ),
                ],
              ),

            _DetailsRow(
              label: LocaleKeys.verification.tr(),
              value:
                  user?.documentVerified ?? false
                      ? LocaleKeys.verificationHasBeenPassedSuccessfully.tr()
                      : LocaleKeys.verificationHasNotBeenPassed.tr(),
              textStyle: AppTextStyles.size17Regular,
            ),

            // if (user?.verificationDoc?.url != null)
            //   TextButton(
            //     onPressed: () async {
            //       await AppLauncher().openPdfInBrowser(
            //         user!.verificationDoc!.url,
            //       );
            //     },
            //     child: Text("Verifikatsion hujjatni ko'rish"),
            //   ),
            AppUtils.hSizedBox4,
          ],
        );
      },
    ).paddingOnly(top: 16.h);
  }
}

class _DetailsRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? textStyle;

  const _DetailsRow({required this.label, required this.value, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.size17Regular.copyWith(color: AppColors.cB7BFCA),
        ),
        SizedBox(
          width: 100.sw,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.cF6F7FB,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              value,
              style:
                  textStyle ??
                  AppTextStyles.size17Medium.copyWith(color: AppColors.c333333),
            ).paddingSymmetric(horizontal: 18.r, vertical: 10.r),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 16.w);
  }
}
