import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_svg.dart';
import '../../../../injection_container.dart';

class AppSearchForm extends StatefulWidget {
  const AppSearchForm({
    super.key,
    required this.controller,
    required this.onTapLocation,
    required this.onChanged,
    required this.onTapFilter,
    required this.enableFilter,
    required this.enableCancel,
    required this.onPressedCancel,
  });

  final TextEditingController controller;
  final VoidCallback onTapLocation;
  final Function(String? value) onChanged;
  final VoidCallback onTapFilter;
  final bool enableFilter;
  final bool enableCancel;
  final VoidCallback onPressedCancel;

  @override
  State<AppSearchForm> createState() => _AppSearchFormState();
}

class _AppSearchFormState extends State<AppSearchForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.cFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: TextFormField(
                  showCursor: false,
                  style: AppTextStyles.size15Medium,
                  keyboardType: TextInputType.none,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  autofocus: false,
                  minLines: 1,
                  maxLines: 1,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    WSearchTextFormFieldQuery(
                      controller: widget.controller,
                      onChanged: widget.onChanged,
                      onPressedCancel: widget.onPressedCancel,
                      enableFilter: widget.enableFilter,
                      onTapFilter: widget.onTapFilter,
                    ).show(context);
                    FocusScope.of(context).unfocus();
                  },
                  decoration: InputDecoration(
                    hintText: LocaleKeys.searchByCategory.tr(),
                    suffixIcon:
                        widget.enableCancel
                            ? IconButton(
                              onPressed: () {
                                widget.onPressedCancel();
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: AppColors.cFF9914,
                              ),
                            )
                            : SvgPicture.asset(
                              AppSvg.icSearch,
                            ).paddingAll(16.r),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.cFF9914),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              Badge(
                isLabelVisible: widget.enableFilter,
                backgroundColor: AppColors.cFF9914,
                child: SizedBox(
                  height: 32.r,
                  width: 32.r,
                  child: IconButton(
                    onPressed: widget.onTapFilter,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(AppSvg.icFilter, height: 32.r),
                  ),
                ).paddingOnly(top: 8.h),
              ),
              SizedBox(
                height: 32.r,
                width: 32.r,
                child: IconButton(
                  onPressed: widget.onTapLocation,
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(AppSvg.icLocation, height: 32.r),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.w, vertical: 10.h),
          Divider(height: 1.h, color: AppColors.cE0E5EB),
        ],
      ),
    );
  }
}

class WSearchTextFormFieldQuery extends StatefulWidget {
  const WSearchTextFormFieldQuery({
    super.key,
    required this.controller,
    required this.onChanged,
    this.enableCancel,
    required this.onPressedCancel,
    required this.enableFilter,
    required this.onTapFilter,
  });

  final TextEditingController controller;
  final Function(String? value) onChanged;
  final bool? enableCancel;
  final VoidCallback onPressedCancel;
  final bool enableFilter;
  final VoidCallback onTapFilter;

  void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54, // or `Colors.transparent` if no dim
      builder: (context) {
        return Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 5), // distance from top
                child: Material(
                  borderRadius: BorderRadius.circular(18.r),
                  color: AppColors.cFFFFFF,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Wrap(children: [this]), // Your custom widget here
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  State<WSearchTextFormFieldQuery> createState() =>
      _WSearchTextFormFieldQueryState();
}

class _WSearchTextFormFieldQueryState extends State<WSearchTextFormFieldQuery> {
  List<String> lastSearchResults = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    final List<String> result = List<String>.from(
      await sl<StorageService>().fetchSearchQuery(),
    );
    setState(() {
      lastSearchResults = result.whereType<String>().toList()..reversed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: AppColors.cFFFFFF,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: true,
                  autofocus: true,
                  style: AppTextStyles.size15Medium,
                  keyboardType: TextInputType.text,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  minLines: 1,
                  maxLines: 1,
                  onTap: () {},
                  onFieldSubmitted: (value) async {
                    if (!_titles.contains(value)) {
                      await sl<StorageService>().putSearchQuery(value);
                    }
                    FocusScope.of(context).unfocus();
                    context.pop();
                  },
                  onSaved: (newValue) async {
                    if (!_titles.contains(newValue)) {
                      await sl<StorageService>().putSearchQuery(newValue!);
                    }
                    FocusScope.of(context).unfocus();
                    context.pop();
                  },
                  decoration: InputDecoration(
                    suffixIcon:
                        widget.enableCancel ?? true
                            ? IconButton(
                              onPressed: () {
                                widget.onPressedCancel();
                                context.pop();
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: AppColors.cFF9914,
                              ),
                            )
                            : SvgPicture.asset(
                              AppSvg.icSearch,
                            ).paddingAll(16.r),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(color: AppColors.cFF9914),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    hintText: LocaleKeys.searchByCategory.tr(),
                  ),
                ),
              ),
              SizedBox(width: 20.r),
              Badge(
                isLabelVisible: widget.enableFilter,
                backgroundColor: AppColors.cFF9914,
                child: IconButton(
                  onPressed: widget.onTapFilter,
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(AppSvg.icFilter, height: 32.r),
                ),
              ),
            ],
          ),
          25.verticalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 11.h,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 11.h,
                children: List.generate(
                  lastSearchResults.length,
                  (index) => InkWell(
                    onTap: () {
                      widget.controller.text = lastSearchResults[index];
                      widget.onChanged(lastSearchResults[index]);
                      context.pop();
                    },
                    child: Row(
                      spacing: 15.w,
                      children: [
                        SizedBox(
                          height: 24.r,
                          width: 24.r,
                          child: SvgPicture.asset(AppSvg.icClock),
                        ),
                        Text(
                          lastSearchResults[index],
                          style: AppTextStyles.size15Regular.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 11.h,
                children: List.generate(
                  5 - lastSearchResults.length,
                  (index) => InkWell(
                    onTap: () {
                      widget.controller.text = _titles[index];
                      widget.onChanged(_titles[index]);
                      context.pop();
                    },
                    child: Row(
                      spacing: 15.w,
                      children: [
                        SizedBox(
                          height: 24.r,
                          width: 24.r,
                          child: SvgPicture.asset(AppSvg.icTrend),
                        ),
                        Text(
                          _titles[index],
                          style: AppTextStyles.size15Regular.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ),
                      ],
                    ),
                  ),
                )..reversed,
              ),
            ],
          ).paddingOnly(left: 8.w),
        ],
      ).paddingAll(16.r),
    );
  }
}

List<String> _titles = [
  LocaleKeys.accounting.tr(),
  LocaleKeys.workForStudent.tr(),
  LocaleKeys.sewing.tr(),
  LocaleKeys.workAtBuilding.tr(),
  LocaleKeys.workAtRestaurant.tr(),
];
