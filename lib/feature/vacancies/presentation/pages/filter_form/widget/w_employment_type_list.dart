
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';

import '../../../../../common/presentation/widget/w_check_box_list_tile.dart';
import '../../../../../common/presentation/widget/w_dialog_action_button.dart';
import '../filter_form.dart';


class WEmploymentTypeList extends StatefulWidget {
  final List<String> employeeTypes;

  const WEmploymentTypeList({super.key, required this.employeeTypes});

  show(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      useRootNavigator: true,
      builder:
          (context) => this.paddingSymmetric(vertical: 180.h, horizontal: 20.w),
    );
  }

  @override
  State<WEmploymentTypeList> createState() => _WEmploymentTypeListState();
}

class _WEmploymentTypeListState extends State<WEmploymentTypeList> {
  late List<String> listEmployee;

  @override
  void initState() {
    listEmployee = List.from(widget.employeeTypes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Material(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cFFFFFF,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 16.r),
                itemCount: employmentTypes.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return WCheckedBoxListTile(
                    value: listEmployee.contains(employeeValues[index]),
                    title: employmentTypes[index],
                    onTap: () {
                      if (listEmployee.contains(employeeValues[index])) {
                        listEmployee.remove(employeeValues[index]);
                      } else {
                        listEmployee.add(employeeValues[index]);
                      }
                      setState(() {});
                    },
                  );
                },
              ).paddingAll(16.r),
            ),
            AppDivider(width: 100.sw, height: 1.h),
            Row(
              children: [
                WDialogActionButton(
                  onTap: () {
                    context.pop(null);
                  },
                  title: LocaleKeys.cancel.tr(),
                  isEnable: true,
                ),
                AppDivider(width: 1.w, height: 55.h),
                WDialogActionButton(
                  onTap: () {
                    context.pop(listEmployee);
                  },
                  title: LocaleKeys.save.tr(),
                  isEnable: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
