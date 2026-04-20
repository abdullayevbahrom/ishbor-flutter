
//
// class WTaskApplyRequests extends StatefulWidget {
//   const WTaskApplyRequests({super.key});
//
//   @override
//   State<WTaskApplyRequests> createState() => _WTaskApplyRequestsState();
// }
//
// class _WTaskApplyRequestsState extends State<WTaskApplyRequests> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TaskViewCubit, TaskViewState>(
//       builder: (context, state) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (state.applyRequestSt.isLoaded() &&
//                 state.listRequests.isNotEmpty)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     LocaleKeys.applicationsForJob.tr(),
//                     style: AppTextStyles.size22Medium.copyWith(
//                       color: AppColors.c2E3A59,
//                     ),
//                   ),
//                   16.verticalSpace,
//                 ],
//               ),
//
//             if (state.applyRequestSt.isLoading()) WTaskApplyRequestsLoading(),
//             if (state.applyRequestSt.isLoaded())
//               ListView.separated(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: state.listRequests.length,
//                 itemBuilder: (context, index) {
//                   final taskRequest = state.listRequests[index];
//                   return Stack(
//                     children: [
//                       SizedBox(
//                         width: 100.sw,
//                         child: DecoratedBox(
//                           decoration: BoxDecoration(
//                             color: AppColors.cF7F9FC,
//                             borderRadius: BorderRadius.circular(18.r),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 spacing: 23.w,
//                                 children: [
//                                   WDefaultUserAvatar(height: 82.h),
//                                   Column(
//                                     spacing: 3.h,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         taskRequest.performer.fullName ?? '',
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: AppTextStyles.size17Medium
//                                             .copyWith(color: AppColors.c2E3A59),
//                                       ),
//                                       Text(
//                                         LocaleKeys.lastSeenAgo.tr(
//                                           args: [
//                                             Formatters.timeAgo(
//                                               taskRequest.createdAt,
//                                             ),
//                                           ],
//                                         ),
//                                         style: AppTextStyles.size14Regular
//                                             .copyWith(color: AppColors.cBDC0C6),
//                                       ),
//                                       Row(
//                                         spacing: 4.w,
//                                         children: [
//                                           SvgPicture.asset(AppIcons.icLike),
//                                           Text(
//                                             '${taskRequest.performer.likesCount ?? 0}',
//                                             style: AppTextStyles.size13Medium
//                                                 .copyWith(
//                                                   color: AppColors.c888888,
//                                                 ),
//                                           ),
//                                           2.horizontalSpace,
//                                           SvgPicture.asset(AppIcons.icDislike),
//                                           Text(
//                                             '${taskRequest.performer.dislikesCount}',
//
//                                             style: AppTextStyles.size13Medium
//                                                 .copyWith(
//                                                   color: AppColors.c888888,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                       2.verticalSpace,
//                                       Row(
//                                         spacing: 4.w,
//                                         children: [
//                                           SvgPicture.asset(AppSvg.icCalendar),
//                                           Text(
//                                             LocaleKeys.respondAgo.tr(
//                                               namedArgs: {
//                                                 "duration": Formatters.timeAgo(
//                                                   taskRequest.createdAt,
//                                                 ),
//                                               },
//                                             ),
//                                             style: AppTextStyles.size13Regular
//                                                 .copyWith(
//                                                   color: AppColors.c2E3A59,
//                                                 ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               15.verticalSpace,
//                               Text(
//                                 Formatters.formatSalary(
//                                   salaryMin: taskRequest.price,
//                                 ),
//                                 style: AppTextStyles.size16Bold.copyWith(
//                                   color: AppColors.cFF9914,
//                                 ),
//                               ),
//                               Text(
//                                 taskRequest.message ?? "",
//                                 style: AppTextStyles.size15Regular.copyWith(
//                                   color: AppColors.c888888,
//                                 ),
//                               ),
//
//
//                               28.verticalSpace,
//                               Row(
//                                 spacing: 8.w,
//                                 children: [
//                                   Expanded(
//                                     flex: 5,
//                                     child: SizedBox(
//                                       height: 40.h,
//                                       child: AppButton(
//                                         onPressed: () {
//                                           context
//                                               .read<TaskViewCubit>()
//                                               .choosePerformer(taskRequest);
//                                         },
//                                         leftIcon:
//                                             state.task?.performer ==
//                                                     taskRequest.performer
//                                                 ? SvgPicture.asset(
//                                                   AppSvg.icChosen,
//                                                 ).paddingOnly(right: 4.w)
//                                                 : null,
//                                         isLoading:
//                                             state.selectedRequest ==
//                                             taskRequest,
//                                         text:
//                                             state.task?.performer ==
//                                                     taskRequest.performer
//                                                 ? LocaleKeys
//                                                     .performerHasBeenChosen
//                                                     .tr()
//                                                 : LocaleKeys.choosePerformer
//                                                     .tr(),
//                                         isAvailable:
//                                             state.task?.performer == null,
//                                         color:
//                                             state.task?.performer ==
//                                                         taskRequest.performer ||
//                                                     state.task?.performer ==
//                                                         null
//                                                 ? AppColors.c15CF74
//                                                 : AppColors.c15CF74
//                                                     .newWithOpacity(.4),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     flex: 3,
//                                     child: SizedBox(
//                                       height: 40.h,
//                                       child: AppButton(
//                                         onPressed: () {
//                                           WSendMessageUser(
//                                             title:
//                                                 LocaleKeys
//                                                     .askQuestionAboutApplication
//                                                     .tr(),
//                                             receiverId:
//                                                 taskRequest.performer.id,
//                                             taskId: state.taskId,
//                                           ).show(context);
//                                         },
//                                         isAvailable:
//                                             state.task?.status != "finished",
//
//                                         text: LocaleKeys.write.tr(),
//                                         color:
//                                             state.task?.status != "finished"
//                                                 ? AppColors.cFF9914
//                                                 : AppColors.cFF9914
//                                                     .newWithOpacity(.3),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               if (state.task?.performer ==
//                                       taskRequest.performer &&
//                                   state.task?.status != "finished")
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     16.verticalSpace,
//                                     Row(
//                                       spacing: 10.w,
//                                       children: [
//                                         Expanded(
//                                           flex: 5,
//                                           child: SizedBox(
//                                             height: 40.h,
//                                             child: AppButton(
//                                               onPressed: () {
//                                                 context
//                                                     .read<TaskViewCubit>()
//                                                     .finishTask(taskRequest);
//                                               },
//                                               isLoading:
//                                                   state.finishSt.isLoading(),
//                                               text: LocaleKeys.finish.tr(),
//                                               color: AppColors.cFF3A44,
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           flex: 3,
//                                           child: SizedBox(
//                                             height: 40.h,
//                                             child: AppButton(
//                                               onPressed: () {
//                                                 context
//                                                     .read<TaskViewCubit>()
//                                                     .cancelPerformer(
//                                                       taskRequest,
//                                                     );
//                                               },
//                                               isLoading:
//                                                   state.cancelSt.isLoading(),
//                                               text: LocaleKeys.cancel.tr(),
//                                               color: AppColors.cB7BFCA,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                             ],
//                           ).paddingAll(16.r),
//                         ),
//                       ),
//                       if (state.task?.status == "finished" &&
//                           state.task?.performer == taskRequest.performer)
//                         Positioned.fill(
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(18.r),
//                               color: AppColors.cFF9914.newWithOpacity(.8),
//                             ),
//                             child: Center(
//                               child: Text(
//                                 LocaleKeys
//                                     .taskCompletedSuccessfullyCompletedByThisUser
//                                     .tr(),
//                                 textAlign: TextAlign.center,
//                                 style: AppTextStyles.size20Bold.copyWith(
//                                   color: AppColors.cFBFBFD,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   );
//                 },
//                 separatorBuilder: (context, index) => 8.verticalSpace,
//               ),
//           ],
//         ).paddingSymmetric(horizontal: 16.w);
//       },
//     );
//   }
// }
//
// class WTaskApplyRequestsLoading extends StatelessWidget {
//   const WTaskApplyRequestsLoading({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Skeletonizer(
//       enabled: true,
//       child: ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder:
//             (context, index) => Container(
//               height: 190.h,
//               width: 100.sw,
//               decoration: BoxDecoration(
//                 color: AppColors.c000000.newWithOpacity(.02),
//                 borderRadius: BorderRadius.circular(18.r),
//               ),
//             ),
//         separatorBuilder: (context, index) => 8.verticalSpace,
//         itemCount: 10,
//       ),
//     );
//   }
// }
