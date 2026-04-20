import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/performers_view/presentation/cubits/task_requests_cubit/task_requests_cubit.dart';
import 'package:top_jobs/models/task_request.dart';

import '../../../../../../core/theme/app_svg.dart';
import '../../../../../ads_view/presentation/widgets/w_send_message_user.dart';
import '../../../../../common/presentation/widget/app_button.dart';
import '../../../../../common/presentation/widget/w_default_user_avatar.dart';

class TaskApplyItem extends StatelessWidget {
  const TaskApplyItem({super.key, required this.taskRequest});

  final TaskRequest taskRequest;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskRequestsCubit, TaskRequestsState>(
      builder: (context, state) {
        bool isPerformer() => state.task?.performer == taskRequest.performer;
        return Stack(
          children: [
            SizedBox(
              width: 100.sw,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.cF7F9FC,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 23.w,
                      children: [
                        WDefaultUserAvatar(height: 82.h),
                        Column(
                          spacing: 3.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              taskRequest.performer.fullName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.size17Medium.copyWith(
                                color: AppColors.c2E3A59,
                              ),
                            ),
                            Text(
                              LocaleKeys.lastSeenAgo.tr(
                                args: [
                                  Formatters.timeAgo(taskRequest.createdAt),
                                ],
                              ),
                              style: AppTextStyles.size14Regular.copyWith(
                                color: AppColors.cBDC0C6,
                              ),
                            ),
                            Row(
                              spacing: 4.w,
                              children: [
                                SvgPicture.asset(AppIcons.icLike),
                                Text(
                                  '${taskRequest.performer.likesCount ?? 0}',
                                  style: AppTextStyles.size13Medium.copyWith(
                                    color: AppColors.c888888,
                                  ),
                                ),
                                2.horizontalSpace,
                                SvgPicture.asset(AppIcons.icDislike),
                                Text(
                                  '${taskRequest.performer.dislikesCount}',

                                  style: AppTextStyles.size13Medium.copyWith(
                                    color: AppColors.c888888,
                                  ),
                                ),
                              ],
                            ),
                            2.verticalSpace,
                            Row(
                              spacing: 4.w,
                              children: [
                                SvgPicture.asset(AppSvg.icCalendar),
                                Text(
                                  LocaleKeys.respondAgo.tr(
                                    namedArgs: {
                                      "duration": Formatters.timeAgo(
                                        taskRequest.createdAt,
                                      ),
                                    },
                                  ),
                                  style: AppTextStyles.size13Regular.copyWith(
                                    color: AppColors.c2E3A59,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Text(
                      Formatters.formatSalary(salaryMin: taskRequest.price),
                      style: AppTextStyles.size16Bold.copyWith(
                        color: AppColors.cFF9914,
                      ),
                    ),
                    Text(
                      taskRequest.message ?? "",
                      style: AppTextStyles.size15Regular.copyWith(
                        color: AppColors.c888888,
                      ),
                    ),

                    28.verticalSpace,
                    Row(
                      spacing: 8.w,
                      children: [
                        Expanded(
                          flex: 5,
                          child: SizedBox(
                            height: 40.h,
                            child: AppButton(
                              onPressed: () {
                                context
                                    .read<TaskRequestsCubit>()
                                    .choosePerformer(taskRequest);
                              },
                              leftIcon:
                                  isPerformer()
                                      ? SvgPicture.asset(
                                        AppSvg.icChosen,
                                      ).paddingOnly(right: 5.w)
                                      : null,
                              isLoading: state.taskRequest == taskRequest,
                              text:
                                  isPerformer()
                                      ? LocaleKeys.performerHasBeenChosen.tr()
                                      : LocaleKeys.choosePerformer.tr(),
                              isAvailable: state.task?.performer == null,
                              color:
                                  isPerformer() || state.task?.performer == null
                                      ? AppColors.c15CF74
                                      : AppColors.c15CF74.newWithOpacity(.4),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 40.h,
                            child: AppButton(
                              onPressed: () {
                                WSendMessageUser(
                                  title:
                                      LocaleKeys.askQuestionAboutApplication
                                          .tr(),
                                  receiverId: taskRequest.performer.id,
                                  taskId: 1,
                                ).show(context);
                              },
                              // isAvailable: state.task?.status != "finished",
                              text: LocaleKeys.write.tr(),
                              color: AppColors.cFF9914,
                              // color:
                              // state.task?.status != "finished"
                              //     ? AppColors.cFF9914
                              //     : AppColors.cFF9914.newWithOpacity(.3),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // if (state.task?.performer == taskRequest.performer &&
                    //     state.task?.status != "finished")
                    if (isPerformer())
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          16.verticalSpace,
                          Row(
                            spacing: 10.w,
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  height: 40.h,
                                  child: AppButton(
                                    onPressed: () {
                                      context
                                          .read<TaskRequestsCubit>()
                                          .finishTask(taskRequest);
                                    },
                                    isLoading: state.finishTaskSt.isLoading(),
                                    text: LocaleKeys.finish.tr(),
                                    color: AppColors.cFF3A44,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 40.h,
                                  child: AppButton(
                                    onPressed: () {
                                      context
                                          .read<TaskRequestsCubit>()
                                          .cancelPerformer(taskRequest);
                                    },
                                    isLoading:
                                        state.cancelPerformerSt.isLoading(),
                                    text: LocaleKeys.cancel.tr(),
                                    color: AppColors.cB7BFCA,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ).paddingAll(16.r),
              ),
            ),
            if (state.task?.status == "finished" &&
                state.task?.performer == taskRequest.performer)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    color: AppColors.cFF9914.newWithOpacity(.8),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.taskCompletedSuccessfullyCompletedByThisUser
                          .tr(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.size20Bold.copyWith(
                        color: AppColors.cFBFBFD,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
