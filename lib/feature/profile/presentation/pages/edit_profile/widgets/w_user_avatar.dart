import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../../models/user.dart';
import '../../../../../common/presentation/pages/w_modal_bottom_sheet_container.dart';
import '../../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../../common/presentation/widget/w_default_user_avatar.dart';
import '../../../../../common/presentation/widget/w_sheet_title.dart';

class WUserAvatar extends StatelessWidget {
  const WUserAvatar({
    super.key,
    required this.user,
    required this.onTapGallery,
    required this.onTapCamera,
    this.userAvatar,
  });

  final VoidCallback onTapGallery;
  final VoidCallback onTapCamera;
  final User? user;
  final File? userAvatar;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 130.r,
        width: 130.r,
        child: Stack(
          children: [
            if (userAvatar != null)
              Container(
                height: 130.r,
                width: 130.r,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(80.r),
                  image: DecorationImage(
                    image: FileImage(userAvatar!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else if (user?.avatar != null && user?.avatar?.urls != null)
              AppCachedNetworkImage(
                height: 130.r,
                radius: 80.r,
                imageUrl: user?.avatar?.urls['original'],
              )
            else
              WDefaultUserAvatar(height: 130.r),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () {
                  WAvatarPicker(
                    onTapGallery: onTapGallery,
                    onTapCamera: onTapCamera,
                    title: LocaleKeys.editAvatar.tr(),
                  ).show(context);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(40.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.c000000.newWithOpacity(.2),
                        blurRadius: 20.r,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    AppSvg.icEditImage,
                    height: 20.r,
                  ).paddingAll(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WAvatarPicker extends StatelessWidget {
  const WAvatarPicker({
    super.key,
    required this.onTapGallery,
    required this.onTapCamera,
    required this.title,
  });

  final VoidCallback onTapGallery;
  final VoidCallback onTapCamera;
  final String title;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      isScrollControlled: true,
      backgroundColor: AppColors.cFFFFFF,
      useSafeArea: true,
      builder: (context) {
        return Wrap(
          children: [
            this.paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.c000000.newWithOpacity(.2),
            blurRadius: 20.r,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            11.verticalSpace,
            WModalSheetDecoratedContainer(),
            20.verticalSpace,
            WSheetTitle(title: title),
            10.verticalSpace,

            WListTile(
              onTap: onTapGallery,
              title: LocaleKeys.pickFromGallery.tr(),
              svgUrl: AppSvg.icGallery,
            ),
            Divider(color: AppColors.cE0E5EB, height: 1.h),
            WListTile(
              onTap: onTapCamera,
              title: LocaleKeys.pickFromCamera.tr(),
              svgUrl: AppSvg.icCamera,
            ),
          ],
        ),
      ),
    );
  }
}

class WListTile extends StatelessWidget {
  const WListTile({
    super.key,
    required this.onTap,
    required this.svgUrl,
    required this.title,
  });

  final VoidCallback onTap;
  final String svgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cFFFFFF,
      child: ListTile(
        enabled: true,
        onTap: onTap,
        splashColor: AppColors.c2E3A59.newWithOpacity(.1),
        leading: SvgPicture.asset(svgUrl),
        title: Text(
          title,
          style: AppTextStyles.size17Medium.copyWith(color: AppColors.c333333),
        ),
      ),
    );
  }
}
