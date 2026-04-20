import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/extentions/string.dart';
import 'package:top_jobs/core/helpers/status_helpers.dart';
import 'package:top_jobs/core/helpers/string_helpers.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_animated_button_wrapper.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_count_see_count_click.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_smart_text.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_svg_icon.dart';
import 'package:top_jobs/feature/vacancies/data/models/new_vacancy_model.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/helpers/formatters.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_utils.dart';
import '../cubits/user_cubit/user_cubit.dart' show UserCubit, UserState;
import 'app_cached_network_image.dart';

class NewVacancyItem extends StatelessWidget {
  const NewVacancyItem({
    super.key,
    this.isFilterAvailable,
    required this.vacancy,
    this.enableLiftUp,
    this.onTapLiftUp,
    this.onTapDelete,
    this.onTapDeactivate,
    this.enableStatus,
    required this.onPressedFavorite,
    this.onTapActivate,
  });

  final bool? isFilterAvailable;
  final NewVacancyModel vacancy;
  final bool? enableLiftUp;
  final bool? enableStatus;
  final VoidCallback? onTapLiftUp;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapDeactivate;
  final VoidCallback onPressedFavorite;
  final VoidCallback? onTapActivate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return AnimatedButtonWrapper(
          onTap: () {
            context.push("/vacancy-view?id=${vacancy.id}");
          },
          child: WDecoratedBoxWithShadow(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: enableStatus ?? false ? 90.w : 130.w,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              vacancy.customer?.fullName ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.size13Regular.copyWith(
                                color: AppColors.c2E3A59,
                                fontFamily: AppLocaleKeys.fontSFProRegular,
                              ),
                            ),
                          ),
                          AppUtils.wSizedBox4,

                          if (vacancy.customer?.documentVerified ?? false)
                            WSvgIcon(svgUrl: AppSvg.icCheckMark),
                        ],
                      ),
                    ),
                    AppUtils.wSizedBox15,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (enableStatus ?? false)
                            Expanded(
                              child: Text(
                                tr(vacancy.status ?? "").capitalize(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: StatusHelpers.getColor(
                                    vacancy.status ?? '',
                                  ),
                                ),
                              ),
                            ),
                          AppUtils.wSizedBox10,
                          WSvgIcon(svgUrl: AppSvg.icCalendar),
                          AppUtils.wSizedBox4,
                          Text(
                            Formatters.timeAgo(
                              vacancy.createdAt ?? DateTime.now(),
                            ),
                            style: AppTextStyles.size13Regular.copyWith(
                              color: AppColors.c2E3A59,
                              fontFamily: AppLocaleKeys.fontSFProRegular,
                            ),
                          ),
                          15.horizontalSpace,
                          if (context.read<UserCubit>().state.status.isLoaded())
                            LikeButton(
                              onTap: (isLiked) async {
                                onPressedFavorite();
                                return null;
                              },
                              size: 25,
                              bubblesSize: 100,
                              isLiked: vacancy.isFavorite ?? false,
                              likeBuilder: (isLiked) {
                                return SizedBox(
                                  child: SvgPicture.asset(
                                    isLiked
                                        ? AppSvg.icHeartFilled
                                        : AppSvg.icHeart,
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  spacing: 18.w,
                  children: [
                    if ((vacancy.imageUrl ?? '').isNotEmpty)
                      AppCachedNetworkImage(
                        height: 75.h,
                        radius: 18.r,
                        imageUrl: vacancy.imageUrl,
                        enableBoxShow: true,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringHelpers.capitalizeFirst(
                              Formatters.translateText(
                                uzText: vacancy.titleUz?.replaceAll("**", ""),
                                ruText: vacancy.titleRu?.replaceAll("**", ""),
                                defaultText: vacancy.title?.replaceAll(
                                  "**",
                                  "",
                                ),
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.size20Bold.copyWith(
                              fontFamily: AppLocaleKeys.fontSFProBold,
                            ),
                          ),
                          Text(
                            Formatters.formatSalary(
                              salaryMin: vacancy.salaryMin,
                              salaryMax: vacancy.salaryMax,
                            ),
                            style: AppTextStyles.size18Bold.copyWith(
                              color: AppColors.cFF9914,
                              fontFamily: AppLocaleKeys.fontSFProBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (vacancy.description != null)
                  SmartText(
                    text: Formatters.translateText(
                      uzText: vacancy.descriptionUz?.replaceAll("**", ""),
                      ruText: vacancy.descriptionRu?.replaceAll("**", ""),
                      defaultText: vacancy.description?.replaceAll("**", ""),
                    ),
                  ).paddingOnly(top: 15.h),
                vacancy.city != null
                    ? Row(
                      spacing: 4.w,
                      children: [
                        WSvgIcon(svgUrl: AppSvg.icLoc),
                        Text(
                          vacancy.city ?? "",
                          style: AppTextStyles.size13Regular.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 16.h)
                    : AppUtils.kSizedBoxShrink,
                isFilterAvailable ?? false
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                          color: AppColors.cFFFFFF,
                          offset: Offset(-25, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(LocaleKeys.edit.tr()),
                                onTap: () {
                                  context.push(
                                    Routes.createVacancy,
                                    extra: vacancy,
                                  );
                                },
                              ),
                              if (enableLiftUp ?? false)
                                PopupMenuItem(
                                  value: 'lift_ip',
                                  onTap: onTapLiftUp,
                                  child: Text(LocaleKeys.liftUp.tr()),
                                ),
                              if (vacancy.status != "deactivated")
                                PopupMenuItem(
                                  value: 'deactivated',
                                  onTap: onTapDeactivate,
                                  child: Text(LocaleKeys.deactivate.tr()),
                                ),
                              if (vacancy.status == "deactivated")
                                PopupMenuItem(
                                  value: 'moderation',
                                  onTap: onTapActivate,
                                  child: Text(LocaleKeys.activate.tr()),
                                ),
                              PopupMenuItem(
                                value: 'delete',
                                onTap: onTapDelete,
                                child: Text(
                                  LocaleKeys.delete.tr(),
                                  style: TextStyle(color: Color(0xffFF0000)),
                                ),
                              ),
                            ];
                          },
                          child: SvgPicture.asset(AppSvg.icFilterGrey),
                        ),

                        //todo count of view and click count
                        WCountSeeCountClick(countContactClick: 0, countSee: 0),
                      ],
                    ).paddingOnly(top: 16.h)
                    : AppUtils.kSizedBoxShrink,
              ],
            ),
          ).paddingSymmetric(horizontal: 16.w, vertical: 8.h),
        );
      },
    );
  }
}
