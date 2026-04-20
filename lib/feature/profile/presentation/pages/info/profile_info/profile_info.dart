import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/profile/presentation/pages/info/profile_info/widget/profile_detail.dart';
import 'package:top_jobs/feature/profile/presentation/pages/info/profile_info/widget/profile_owner_statistics.dart';

import '../../../../../../core/router/route_names.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../common/presentation/cubits/locale_cubit/locale_cubit.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/app_header.dart';
import '../../../../../common/presentation/widget/footer.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: SafeArea(
                  bottom: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppHeader(isPopAvailable: true),
                      Expanded(
                        child: WRefreshIndicator(
                          onRefresh: () async {
                            await context.read<UserCubit>().fetchUser();
                          },
                          child: Skeletonizer(
                            enabled: state.status.isLoading(),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  40.verticalSpace,
                                  Text(
                                    LocaleKeys.myInfo.tr(),
                                    style: AppTextStyles.size28Bold.copyWith(
                                      color: AppColors.c2E3A59,
                                    ),
                                  ).paddingSymmetric(horizontal: 16.w),
                                  24.verticalSpace,
                                  WDecoratedBox(
                                    bgColor: AppColors.cFBFBFD,
                                    radius: 18.r,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ProfileOwnerStatistics(),
                                        ProfileDetails(),
                                      ],
                                    ),
                                  ).paddingSymmetric(horizontal: 16.w),
                                  AppButton(
                                    onPressed: () {
                                      context.push(Routes.edit_profile);
                                    },
                                    textStyle: AppTextStyles.size15Medium
                                        .copyWith(color: AppColors.cFFFFFF),
                                    width: 100.sw,
                                    radius: 12.r,
                                    verticalPadding: 14.h,
                                    leftIcon: SvgPicture.asset(
                                      AppSvg.icEdit,
                                    ).paddingOnly(right: 6.w),
                                    text: LocaleKeys.changeProfile.tr(),
                                    color: AppColors.cFF9914,
                                  ).paddingAll(16.r),
                                  Footer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// class _ImagePreview extends StatelessWidget {
//   final ModelImage.Image? image;
//
//   const _ImagePreview({this.image});
//
//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//           color: Color(0xfff0f2f6),
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: Color(0xffe0e5eb), width: 2)),
//       child: SizedBox(
//         width: 45,
//         height: 45,
//         child: image != null
//             ? ClipRRect(
//           borderRadius: BorderRadius.circular(5),
//           child: Image.network(image?.urls['100x100'],
//               width: 45, height: 45, fit: BoxFit.cover),
//         )
//             : null,
//       ),
//     );
//   }
// }
