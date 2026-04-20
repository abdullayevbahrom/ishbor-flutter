import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_decorated_box.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_radio_list_tile.dart';

List<String> _employmentTypes = [
  LocaleKeys.fullEmployment.tr(),
  LocaleKeys.partialEmployment.tr(),
  LocaleKeys.internShip.tr(),
  LocaleKeys.otheR.tr(),
];
List<String> _employmentKeys = [
  "full employment",
  "partial employment",
  "internship",
  "other",
];

class WVacancyEmploymentType extends StatefulWidget {
  const WVacancyEmploymentType({
    super.key,
    required this.onTappedTile,
    this.value,
    required this.startTime,
    required this.endTime,
  });

  final Function(String value) onTappedTile;
  final String? value;
  final TextEditingController startTime;
  final TextEditingController endTime;

  @override
  State<WVacancyEmploymentType> createState() => _WVacancyEmploymentTypeState();
}

class _WVacancyEmploymentTypeState extends State<WVacancyEmploymentType> {
  @override
  Widget build(BuildContext context) {
    return WDecoratedBox(
      radius: 16.r,
      bgColor: AppColors.cFBFBFD,
      child: Column(
        spacing: 16.h,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.employmentType.tr(),
            style: AppTextStyles.size22Bold.copyWith(color: AppColors.c2E3A59),
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: _employmentTypes.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5.r,
              crossAxisSpacing: 5.r,
              childAspectRatio: 5,
            ),
            itemBuilder:
                (context, index) => WRadioListTile(
                  title: _employmentTypes[index],
                  value: _employmentKeys[index] == widget.value,
                  onTap: () {
                    widget.onTappedTile(_employmentKeys[index]);
                  },
                ),
          ),
          10.verticalSpace,
          Column(
            spacing: 8.h,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: LocaleKeys.workTime.tr(),
                  style: AppTextStyles.size15Medium.copyWith(
                    color: AppColors.c333333,
                  ),
                  children: [
                    TextSpan(
                      text: " (${LocaleKeys.optional.tr()})",
                      style: AppTextStyles.size15Medium.copyWith(
                        color: AppColors.cBDC0C6,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                spacing: 8.w,
                children: [
                  Expanded(
                    child: AppTextFormField(
                      hintText: LocaleKeys.from.tr(),
                      controller: widget.startTime,
                      keyBoardType: TextInputType.none,

                      onTap: () async {
                        final result = await WCupertinoTimePicker(
                          initialTime:
                              widget.startTime.text.isEmpty
                                  ? "09:00"
                                  : widget.startTime.text,
                        ).show(context);

                        if (result != null) {
                          widget.startTime.text = result;
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: AppTextFormField(

                      hintText: LocaleKeys.to.tr(),
                      controller: widget.endTime,
                      keyBoardType: TextInputType.none,
                      onTap: () async{
                        final result = await WCupertinoTimePicker(
                          initialTime:
                          widget.endTime.text.isEmpty
                              ? "18:00"
                              : widget.endTime.text,
                        ).show(context);

                        if (result != null) {
                          widget.endTime.text = result;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ).paddingAll(16.r),
    ).paddingSymmetric(horizontal: 16.w);
  }
}

class WCupertinoTimePicker extends StatefulWidget {
  const WCupertinoTimePicker({super.key, required this.initialTime});

  final String initialTime;

  show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cFFFFFF,
      builder: (context) => this,
    );
  }

  @override
  State<WCupertinoTimePicker> createState() => _WCupertinoTimePickerState();
}

class _WCupertinoTimePickerState extends State<WCupertinoTimePicker> {
  String time = '';
  int hour = 9;
  int second = 0;

  @override
  void initState() {
    time = widget.initialTime;
    final times = widget.initialTime.split(":");
    if (times.length == 2) {
      hour = int.tryParse(times[0].trim()) ?? hour;
      second = int.tryParse(times[1].trim()) ?? second;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          WModalSheetDecoratedContainer().paddingOnly(top: 11.h),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  context.pop(null);
                },
                child: Text(
                  LocaleKeys.cancel.tr(),
                  style: AppTextStyles.size17Medium.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pop(time);
                },
                child: Text(
                  LocaleKeys.save.tr(),
                  style: AppTextStyles.size17Medium.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              backgroundColor: AppColors.cFFFFFF,
              showTimeSeparator: true,
              initialDateTime: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                hour,
                second,
              ),
              use24hFormat: true,
              onDateTimeChanged: (value) {
                setState(() {
                  time =
                      "${value.hour.toString().padLeft(2, '0')} : ${value.minute.toString().padLeft(2, '0')}";
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
