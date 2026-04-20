import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/feature/ads_view/data/models/task_request_params.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/task_view_page/widgets/w_apply_request_modal.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/task_view_page/widgets/w_own_request.dart';
import 'package:top_jobs/feature/ads_view/presentation/pages/task_view_page/widgets/w_similar_tasks.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_header_action.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_loading.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_title_view.dart';
import 'package:top_jobs/feature/auth/presentation/pages/login_page/login_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import '../../../../../core/constants/locale_keys.g.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../../models/user.dart';
import '../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../common/presentation/widget/app_banner.dart';
import '../../../../common/presentation/widget/app_button.dart';
import '../../../../common/presentation/widget/app_cached_network_image.dart';
import '../../../../common/presentation/widget/footer.dart';
import '../../../../common/presentation/widget/w_share_content_actions.dart';
import '../../cubits/task_view_cubit/task_view_cubit.dart';
import '../../widgets/w_ads_author_connect.dart';
import '../../widgets/w_ads_author_pre_view.dart';
import '../../widgets/w_ads_location_view.dart';

class WTaskViewPage extends StatefulWidget {
  WTaskViewPage({super.key, required this.taskId});

  final int taskId;

  @override
  State<WTaskViewPage> createState() => _WTaskViewPageState();
}

class _WTaskViewPageState extends State<WTaskViewPage> {
  late TextEditingController _controller;
  late TextEditingController _priceController;
  late ScrollController _scrollController;
  static const _scrollThreshold = 800;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _controller = TextEditingController();
    _priceController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.addListener(_onChanged);
    });
    super.initState();
  }

  void _onChanged() {
    final text = _controller.text;
    if (text.length > 120) {
      final newText = text.substring(0, 120);
      _controller.value = _controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll < _scrollThreshold) {
      context.read<TaskViewCubit>().checkLoadMoreData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _controller.removeListener(_onChanged);
    _controller.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (previous, current) => previous.status != current.status,
      buildWhen: (previous, current) => previous.status != current.status,
      listener: (context, userState) {
        if (!userState.status.isLoaded()) {
          context.read<UserCubit>().checkUser();
        }
      },
      builder: (context, userState) {
        return BlocConsumer<TaskViewCubit, TaskViewState>(
          listener: (context, state) {
            if (state.requestTasksSt.isLoaded()) {
              _priceController.clear();
              _controller.clear();
            }

            if (state.status.isLoaded()) {
              if (state.task?.price != null && state.task?.price != 0) {
                _priceController.text = Formatters.moneyFormat(
                  state.task!.price!.toInt().toString(),
                );
              }
            }
          },
          builder: (context, state) {
            return WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFFFFFF,
                body: Column(
                  children: [
                    AppHeader(
                      isPopAvailable: true,
                      popUpMenu: WAdsHeaderAction(
                        onPressedReply: () {},
                        onPressedFavorite: () {
                          context.read<TaskViewCubit>().toggleTask();
                        },
                        isFavorite: state.task?.isFavorite ?? false,
                      ),
                    ),
                    Expanded(child: buildBody(state, context, userState.user)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBody(TaskViewState state, BuildContext context, User? user) {
    if (state.status.isLoaded()) {
      final task = state.task;
      return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        physics: const AlwaysScrollableScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          WAdsViewTitle(
            title: Formatters.translateText(
              uzText: task?.titleUz,
              ruText: task?.titleRu,
              defaultText: task?.title,
            ),
            createdAt: task?.createdAt ?? DateTime.now(),
            city: task?.city ?? "Tashkent",
            salary: Formatters.formatSalary(salaryMin: task?.price),
            categories: task?.categories,
          ),
          26.verticalSpace,
          // WServiceDescription(service: ser),
          SizedBox(
            width: 100.sw,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.cE0E5EB),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.completeTaskTill.tr(),
                    style: AppTextStyles.size18Medium,
                  ).paddingOnly(bottom: 8.h),
                  Text(
                    "${Formatters.formatDateRu(task?.expiresAt ?? DateTime.now())}",
                    style: AppTextStyles.size17Regular,
                  ),
                  AppUtils.hSizedBox16,
                  Text(
                    LocaleKeys.paymentMethods.tr(),
                    style: AppTextStyles.size18Medium,
                  ).paddingOnly(bottom: 4.h),
                  Text(
                    (task?.paymentMethods ?? []).isEmpty
                        ? LocaleKeys.cash.tr()
                        : (task?.paymentMethods ?? []).contains("cash")
                        ? LocaleKeys.cash.tr()
                        : LocaleKeys.onlinePayment.tr(),
                    style: AppTextStyles.size17Regular,
                  ),
                  AppUtils.hSizedBox24,
                  Text(
                    Formatters.translateText(
                      uzText: task?.descriptionUz,
                      ruText: task?.descriptionRu,
                      defaultText: task?.description,
                    ),
                    style: AppTextStyles.size17Regular,
                  ),
                ],
              ).paddingAll(16.sp),
            ),
          ).paddingSymmetric(horizontal: 16.w),
          17.verticalSpace,
          if ((task?.images ?? []).isNotEmpty &&
              task?.images.first.urls != null)
            AppCachedNetworkImage(
              height: 295.h,
              radius: 16.r,
              imageUrl: task?.images.first.urls['original'],
            ).paddingSymmetric(horizontal: 16.w),
          19.verticalSpace,
          if (user != task?.customer)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WAdsAuthorConnect(
                  phoneNumbers: [
                    task?.phoneNumber,
                    task?.phoneNumber1,
                    task?.phoneNumber2,
                    task?.phoneNumber3,
                  ],
                  customerId: task?.customer.id ?? 0,
                  taskId: task?.id,
                  hasUserRequest: task?.hasUserRequest,
                  onPressedApply: () {
                    WTaskApply(
                      isLoading: state.requestTasksSt.isLoading(),
                      descriptionController: _controller,
                      priceController: _priceController,
                      onPressedSend: () {
                        context.read<TaskViewCubit>().applyRequestTask(
                          TaskRequestParams(
                            taskId: widget.taskId,
                            message: _controller.text.trim(),
                            price: _priceController.text.trim().replaceAll(
                              " ",
                              '',
                            ),
                          ),
                        );
                      },
                    ).show(context);
                  },
                ),
              ],
            ),
          if (user == task?.customer)
            AppButton(
              onPressed: () {
                context.push(Routes.task_performers, extra: state.task);
              },
              verticalPadding: 12.h,
              text: LocaleKeys.seeAllApplies.tr(),
              color: AppColors.c15CF74,
            ).paddingSymmetric(horizontal: 16.w),
          22.verticalSpace,
          WShareAdsLink(link: "https://api.ishbor.uz/task-view?id=${task?.id}"),
          WAdsAuthorPreView(
            onPressedAuthorAds: () {
              if (user == task?.customer) {
                context.push(Routes.profileInfo);
              } else {
                context.push(Routes.othersProfile, extra: task?.customer);
              }
            },
            name: task?.customer.fullName ?? '',
            city: task?.customer.city ?? 'Tashkent',
            countLike: "${task?.customer.likesCount ?? 0}",
            countDislike: "${task?.customer.dislikesCount ?? 0}",
            actionName: LocaleKeys.authorAllAds.tr(),
            isVerified: task?.customer.documentVerified,
            imageUrl: task?.customer.avatar?.urls['original'],
          ),
          WAdsLocationView(taskModel: task),
          if (state.myRequest != null)
            WOwnRequest(taskRequest: state.myRequest!),
          BlocProvider.value(
            value: context.read<TaskViewCubit>(),
            child: WSimilarTasks(),
          ),
          14.verticalSpace,
          AppBanner(
            title: LocaleKeys.createTask.tr(),
            onPressed: () {
              if (context.read<UserCubit>().state.status.isLoaded()) {
                context.push(Routes.createTask);
              } else {
                LoginPage().show(context);
              }
            },
          ),
          Footer(),
        ],
      );
    }
    return const WAdsViewLoading();
  }
}
