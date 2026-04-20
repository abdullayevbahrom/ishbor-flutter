import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../../core/utils/app_utils.dart';
import '../../../../../../injection_container.dart';
import '../../../../../common/presentation/widget/service_item.dart';
import '../../../../../common/presentation/widget/task_item.dart';
import '../../../../../common/presentation/widget/vacancy_item.dart';
import '../../../../../common/presentation/widget/w_error_widget.dart';
import '../../../../../common/presentation/widget/w_loading_item.dart';
import '../../../cubits/other_profile_cubit/other_profile_cubit.dart';

class WTabBar extends StatefulWidget {
  final int userId;

  WTabBar({super.key, required this.userId});

  @override
  State<WTabBar> createState() => _WTabBarState();
}

class _WTabBarState extends State<WTabBar> {
  List<String> tabs = [
    // LocaleKeys.allAdvertisements.tr(),
    LocaleKeys.Vacancies.tr(),
    LocaleKeys.services.tr(),
    LocaleKeys.tasks.tr(),
  ];

  final otherProfileCubit = sl<OtherProfileCubit>();

  @override
  void initState() {
    otherProfileCubit.fetchVacancy(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: otherProfileCubit,
      child: BlocBuilder<OtherProfileCubit, OtherProfileState>(
        builder: (context, state) {
          return DefaultTabController(
            length: tabs.length,
            child: Column(
              children: [
                SizedBox(
                  height: 55.h,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (value) {
                          otherProfileCubit.updateIndex(
                            index: value,
                            userId: widget.userId,
                          );
                        },
                        // isScrollable: true,
                        dividerHeight: 3.h,
                        dividerColor: AppColors.cE0E5EB,
                        indicatorAnimation: TabIndicatorAnimation.linear,
                        indicatorColor: AppColors.cFF9914,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 2,
                        tabAlignment: TabAlignment.center,
                        labelPadding: EdgeInsets.only(
                          top: 12.h,
                          bottom: 12.h,
                          left: 12.w,
                          right: 12.w,
                        ),

                        tabs: List.generate(
                          tabs.length,
                          (index) => Text(
                            "${tabs[index]}",
                            style: AppTextStyles.size15Medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.index == 0)
                  Column(
                    children: [
                      if (state.vacancy.isLoading()) WLoading(),
                      if (state.vacancy.isError())
                        WErrorWidget(
                          errorText: state.vacancyError,
                        ).paddingOnly(top: 40.h),

                      if (state.vacancy.isLoaded())
                        if ((state.listVacancy?.items ?? []).isEmpty)
                          WErrorWidget(
                            errorText: LocaleKeys.noVacancies.tr(),
                          ).paddingOnly(top: 40.h),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.listVacancy?.items.length ?? 0,
                        padding: EdgeInsets.only(top: 20.h),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return VacancyItem(
                            onPressedFavorite: () {},

                            vacancy: state.listVacancy!.items[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppUtils.hSizedBox4;
                        },
                      ),
                    ],
                  ),
                if (state.index == 1)
                  Column(
                    children: [
                      if (state.service.isLoading()) WLoading(),
                      if (state.service.isError())
                        WErrorWidget(
                          errorText: state.serviceError,
                        ).paddingOnly(top: 40.h),

                      if (state.service.isLoaded())
                        if ((state.listService?.items ?? []).isEmpty)
                          WErrorWidget(
                            errorText: LocaleKeys.noServices.tr(),
                          ).paddingOnly(top: 40.h),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.listService?.items.length ?? 0,
                        padding: EdgeInsets.only(top: 10.h),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ServiceItem(
                            onPressedFavorite: () {},
                            service: state.listService!.items[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppUtils.hSizedBox4;
                        },
                      ),
                    ],
                  ),
                if (state.index == 2)
                  Column(
                    children: [
                      if (state.task.isLoading()) WLoading(),
                      if (state.task.isError())
                        WErrorWidget(
                          errorText: state.taskError,
                        ).paddingOnly(top: 40.h),

                      if (state.task.isLoaded())
                        if ((state.listTask?.items ?? []).isEmpty)
                          WErrorWidget(
                            errorText: LocaleKeys.noTasks.tr(),
                          ).paddingOnly(top: 40.h),
                      ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.listTask?.items.length ?? 0,
                        padding: EdgeInsets.only(top: 40.h),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskItem(
                            onPressedFavorite: () {},
                            task: state.listTask!.items[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppUtils.hSizedBox32;
                        },
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
