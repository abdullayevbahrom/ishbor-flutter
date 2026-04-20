import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

class WCategoriesPage extends StatefulWidget {
  const WCategoriesPage({super.key, required this.categories});

  final List<int> categories;

  @override
  State<WCategoriesPage> createState() => _WCategoriesPageState();
}

class _WCategoriesPageState extends State<WCategoriesPage> {
  List<int> selectedCategories = [];

  @override
  void initState() {
    selectedCategories = widget.categories;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        return WLayout(
          bottom: true,
          child: Scaffold(
            backgroundColor: AppColors.cFFFFFF,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.pop(selectedCategories);
                },
                icon: SvgPicture.asset(AppSvg.icBack),
              ).paddingOnly(left: 10.w),
            ),
            body: SingleChildScrollView(
              controller: context.read<CategoryCubit>().scrollController,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),

              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.verticalSpace,
                  Text(
                    LocaleKeys.chooseCategory.tr(),
                    style: AppTextStyles.size28Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  24.verticalSpace,
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 30.h),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemBuilder: (context, index) {
                      final category = state.categories?.items[index];
                      return Wrap(
                        children: [
                          InkWell(
                            onTap: () {
                              if (selectedCategories.contains(category?.id)) {
                                setState(() {
                                  selectedCategories.remove(category?.id);
                                });
                              } else {
                                setState(() {
                                  selectedCategories.add(category!.id);
                                });
                              }
                            },
                            borderRadius: BorderRadius.circular(8.r),
                            child: Ink(
                              decoration: BoxDecoration(
                                color:
                                    selectedCategories.contains(category?.id)
                                        ? AppColors.cFF9914
                                        : AppColors.cF6F7FB,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                category
                                        ?.translations[context
                                                    .locale
                                                    .languageCode ==
                                                'ru'
                                            ? 0
                                            : 1]
                                        .name ??
                                    "",
                                style: AppTextStyles.size17Regular.copyWith(
                                  color:
                                      selectedCategories.contains(category?.id)
                                          ? AppColors.cFFFFFF
                                          : AppColors.c222222,
                                ),
                              ).paddingSymmetric(
                                horizontal: 8.w,
                                vertical: 6.h,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => 8.verticalSpace,
                    itemCount: state.categories?.items.length ?? 0,
                  ),
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ),
        );
      },
    );
  }
}
