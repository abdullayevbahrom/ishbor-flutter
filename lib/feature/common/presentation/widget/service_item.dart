import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/extentions/string.dart';
import 'package:top_jobs/core/router/route_names.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_animated_button_wrapper.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_smart_text.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_svg_icon.dart';

import '../../../../core/constants/app_locale_keys.dart';
import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/helpers/formatters.dart';
import '../../../../core/helpers/status_helpers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_utils.dart';
import '../../../services/data/models/service.dart';
import '../cubits/user_cubit/user_cubit.dart';
import 'app_cached_network_image.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({
    super.key,
    this.isPopButtonAvailable,
    required this.service,
    this.enableStatus,
    this.onTapLiftUp,
    this.onTapDeactivate,
    this.onTapDelete,
    this.enableLiftUp,
    required this.onPressedFavorite,
    this.onTapActivate,
  });

  final bool? isPopButtonAvailable;
  final bool? enableStatus;
  final bool? enableLiftUp;
  final ServiceModel service;
  final VoidCallback? onTapLiftUp;
  final VoidCallback? onTapDeactivate;
  final VoidCallback? onTapDelete;
  final VoidCallback onPressedFavorite;
  final VoidCallback? onTapActivate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return AnimatedButtonWrapper(
          onTap: () {
            context.push("/service-view?id=${service.id}");

            // context.push(Routes.serviceView, extra: service);
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
                              "${service.customer.fullName}",
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.size13Regular.copyWith(
                                color: AppColors.c2E3A59,
                                fontFamily: AppLocaleKeys.fontSFProRegular,
                              ),
                            ),
                          ),
                          AppUtils.wSizedBox4,
                          if (service.customer.documentVerified ?? false)
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
                                tr(service.status).capitalize(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.size15Medium.copyWith(
                                  color: StatusHelpers.getColor(service.status),
                                ),
                              ),
                            ),
                          AppUtils.wSizedBox10,
                          WSvgIcon(svgUrl: AppSvg.icCalendar),
                          AppUtils.wSizedBox4,
                          Text(
                            Formatters.timeAgo(service.createdAt),
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
                              isLiked: service.isFavorite ?? false,
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
                    if (service.images != null &&
                        (service.images ?? []).isNotEmpty)
                      AppCachedNetworkImage(
                        height: 75.h,
                        radius: 18.r,
                        imageUrl: service.images?.first.urls['original'],
                        enableBoxShow: true,
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Formatters.translateText(
                              uzText: service.titleUz,
                              ruText: service.titleRu,
                              defaultText: service.title,
                            ),
                            softWrap: true,
                            maxLines: 2,
                            style: AppTextStyles.size20Bold.copyWith(
                              fontFamily: AppLocaleKeys.fontSFProBold,
                            ),
                          ),
                          Text(
                            Formatters.formatSalary(salaryMin: service.price),
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
                SmartText(
                  text: Formatters.translateText(
                    uzText: service.descriptionUz,
                    ruText: service.descriptionRu,
                    defaultText: service.description,
                  ),
                ).paddingOnly(top: 20.h),
                service.city != null
                    ? Row(
                      spacing: 4.w,
                      children: [
                        WSvgIcon(svgUrl: AppSvg.icLoc),
                        Text(
                          service.city ?? '',
                          style: AppTextStyles.size13Regular.copyWith(
                            color: AppColors.c2E3A59,
                            fontFamily: AppLocaleKeys.fontSFProRegular
                          ),
                        ),
                      ],
                    ).paddingOnly(top: 16.h)
                    : AppUtils.kSizedBoxShrink,

                isPopButtonAvailable ?? false
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton(
                          color: AppColors.cFFFFFF,
                          offset: Offset(-25, 30),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(LocaleKeys.edit.tr()),
                                onTap: () {
                                  context.push(
                                    Routes.createService,
                                    extra: service,
                                  );
                                },
                              ),
                              if (enableLiftUp ?? false)
                                PopupMenuItem(
                                  value: 'lift_up',
                                  onTap: onTapLiftUp,
                                  child: Text(LocaleKeys.liftUp.tr()),
                                ),
                              if (service.status != 'deactivated')
                                PopupMenuItem(
                                  value: 'deactivate',
                                  onTap: onTapDeactivate,
                                  child: Text(LocaleKeys.deactivate.tr()),
                                ),
                              if (service.status == 'deactivated')
                                PopupMenuItem(
                                  value: 'activate',
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
                          child:SvgPicture.asset(AppSvg.icFilterGrey),
                        ),
                        /*
                        WCountSeeCountClick(
                          countContactClick: service.clickCount,
                          countSee: service.viewCount,
                        ),
                         */
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
