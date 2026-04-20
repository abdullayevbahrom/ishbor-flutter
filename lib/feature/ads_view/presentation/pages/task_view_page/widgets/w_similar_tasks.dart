import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/task_view_cubit/task_view_cubit.dart';

import '../../../../../../core/helpers/category_helpers.dart';
import '../../../../../../core/helpers/formatters.dart';
import '../../../../../common/presentation/widget/w_similar_content_item.dart';
import '../../../widgets/w_similar_ads_loading.dart';

class WSimilarTasks extends StatelessWidget {
  const WSimilarTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskViewCubit, TaskViewState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.similarTasksSt.isLoaded() &&
                (state.listTasks?.items ?? []).isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.similarTasks.tr(),
                    style: AppTextStyles.size22Medium.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  16.verticalSpace,
                ],
              ),
            if (state.similarTasksSt.isLoading()) WSimilarAdsLoading(),
            if (state.similarTasksSt.isLoaded())
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.listTasks?.items.length ?? 0,
                scrollDirection: Axis.vertical,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => 8.verticalSpace,
                itemBuilder: (context, index) {
                  final task = state.listTasks?.items[index];
                  return InkWell(
                    onTap: () {
                      context.push("/task-view?id=${task.id}");
                    },
                    borderRadius: BorderRadius.circular(18.r),
                    child: WSimilarContentViewItem(
                      category: CategoryHelpers.categoryName(
                        task!.categories,
                        context,
                      ),
                      dateTime: Formatters.timeAgo(
                        task.createdAt,
                      ),
                      title: Formatters.translateText(
                        uzText: task.titleUz,
                        ruText: task.titleRu,
                        defaultText: task.title,
                      ),
                      salaryMin: task.price,
                      imageUrl:
                          (task.images ?? []).isNotEmpty
                              ? task.images.first.urls['original']
                              : null,
                      bgColor: AppColors.cF7F9FC,
                    ),
                  );
                },
              ),
            if (state.isLoadingMore) WSimilarAdsLoading(),
          ],
        ).paddingSymmetric(horizontal: 16.w);
      },
    );
  }
}
