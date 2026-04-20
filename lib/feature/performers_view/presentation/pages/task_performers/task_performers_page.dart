import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/category_helpers.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_similar_content_item.dart';
import 'package:top_jobs/feature/performers_view/presentation/cubits/task_requests_cubit/task_requests_cubit.dart';
import 'package:top_jobs/feature/performers_view/presentation/pages/task_performers/widget/task_applies_loading.dart';
import 'package:top_jobs/feature/performers_view/presentation/pages/task_performers/widget/task_apply_item.dart';
import 'package:top_jobs/feature/tasks/data/models/task_model.dart';

import '../../../../../injection_container.dart';

class TaskPerformersPage extends StatelessWidget {
  const TaskPerformersPage({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskRequestsCubit>()..requestApplyTask(taskModel),
      child: BlocBuilder<TaskRequestsCubit, TaskRequestsState>(
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(isPopAvailable: true),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        40.verticalSpace,
                        Text(
                          LocaleKeys.choosePerformer.tr(),
                          style: AppTextStyles.size28Bold.copyWith(
                            color: AppColors.c2E3A59,
                          ),
                        ),
                        15.verticalSpace,
                        WSimilarContentViewItem(
                          category: CategoryHelpers.categoryName(
                            taskModel.categories,
                            context,
                          ),
                          dateTime: Formatters.timeAgo(taskModel.createdAt),
                          title: Formatters.translateText(
                            uzText: taskModel.titleUz,
                            ruText: taskModel.titleRu,
                            defaultText: taskModel.title,
                          ),
                          salaryMin: taskModel.price,
                          bgColor: AppColors.cF7F9FC,
                          imageUrl:
                              (taskModel.images ?? []).isNotEmpty &&
                                      taskModel.images.first.urls.isNotEmpty
                                  ? taskModel.images.first.urls['original']
                                  : null,
                        ),
                        20.verticalSpace,
                        if (state.status.isLoading())
                          Expanded(child: WTaskApplyRequestsLoading()),
                        if (state.status.isLoaded())
                          Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder:
                                  (context, index) => TaskApplyItem(
                                    taskRequest:
                                        state.listTaskRequest!.items[index],
                                  ),
                              separatorBuilder:
                                  (context, index) => 8.verticalSpace,
                              itemCount:
                                  state.listTaskRequest?.items.length ?? 0,
                            ),
                          ),
                      ],
                    ).paddingSymmetric(horizontal: 16.w),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
