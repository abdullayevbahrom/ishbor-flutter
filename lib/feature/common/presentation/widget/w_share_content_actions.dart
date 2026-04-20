import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/app_launcher.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_toasttifications.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../core/theme/app_text_styles.dart';

class WShareAdsLink extends StatelessWidget {
  const WShareAdsLink({super.key, required this.link});

  final String link;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            LocaleKeys.share.tr(),
            style: AppTextStyles.size17Medium.copyWith(
              color: AppColors.c2E3A59,
            ),
          ),
          10.verticalSpace,
          Row(
            spacing: 7.w,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WShareButton(
                onPressed: () async {
                  await AppLauncher().shareLinkWithTelegram(link);
                },
                svgIcon: AppSvg.icTg,
              ),
              WShareButton(
                onPressed: () async {
                  await AppLauncher().shareLinkWithFacebook(link);
                },
                svgIcon: AppSvg.icFaceBook,
              ),
              WShareButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: link));
                  showInfoToast(LocaleKeys.savedToClipboard.tr());
                },
                svgIcon: AppSvg.icLink,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WShareButton extends StatelessWidget {
  const WShareButton({
    super.key,
    required this.svgIcon,
    required this.onPressed,
  });

  final String svgIcon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10.r),
      child: Ink(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
          color: AppColors.cF7F9FC,
          borderRadius: BorderRadius.circular(10.r),
        ),

        child: SvgPicture.asset(svgIcon).paddingAll(10.r),
      ),
    );
  }
}
