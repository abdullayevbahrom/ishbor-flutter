import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_radio_list_tile.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_sheet_title.dart';

class WGenderPicker extends StatefulWidget {
  const WGenderPicker({super.key, required this.genderController});

  final TextEditingController genderController;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: AppColors.cFFFFFF,
      builder:
          (context) => Wrap(
            children: [
              this.paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
            ],
          ),
    );
  }

  @override
  State<WGenderPicker> createState() => _WGenderPickerState();
}

class _WGenderPickerState extends State<WGenderPicker> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            11.verticalSpace,
            WModalSheetDecoratedContainer(),
            22.verticalSpace,
            WSheetTitle(title: LocaleKeys.chooseGender.tr()),
            15.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WRadioListTile(
                  title: LocaleKeys.Male.tr(),
                  value:
                      widget.genderController.text.trim() ==
                      LocaleKeys.Male.tr(),
                  onTap: () { 
                    setState(() {
                      widget.genderController.text = LocaleKeys.Male.tr();
                    });
                  },
                ),
                WRadioListTile(
                  title: LocaleKeys.Female.tr(),
                  value:
                      widget.genderController.text.trim() ==
                      LocaleKeys.Female.tr(),
                  onTap: () {
                    setState(() {
                      widget.genderController.text = LocaleKeys.Female.tr();
                    });
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16.w),
          ],
        ),
      ),
    );
  }
}
