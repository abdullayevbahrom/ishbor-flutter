import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_error_page/w_error_page.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_divider.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_refresh_indicator.dart';
import 'package:top_jobs/feature/messages/presentation/pages/messages_page/widgets/message_item.dart';
import 'package:top_jobs/feature/messages/presentation/pages/messages_page/widgets/messages_loading.dart';

import '../../../../../core/router/route_names.dart';
import '../../../../main/presentation/cubit/main_cubit/main_cubit.dart';
import '../../cubits/message_cubit/message_cubit.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  static const int _scrollPix = 80;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.addListener(_onScroll);
    });

    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final _currentScroll = _scrollController.position.pixels;
    if (context.read<MainCubit>().state.isOpen) {
      context.read<MainCubit>().updateOpen(false);
    }

    if (context.read<MainCubit>().state.isNotificationMenuOpen) {
      context.read<MainCubit>().updateNtfMenu(false);
    }
    if (maxScroll - _currentScroll < _scrollPix) {
      context.read<MessageCubit>().checkLoadMoreData();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.status.isLoaded()) {
          context.read<MessageCubit>().fetchData();
        }
      },
      child: BlocBuilder<MessageCubit, MessageState>(
        builder: (context, state) {
          return WLayout(
            child: Scaffold(
              backgroundColor: AppColors.cFFFFFF,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppHeader(popUpMenu: SizedBox.shrink()),
                  10.verticalSpace,
                  if (state.status.isError())
                    Expanded(
                      child: WErrorPage(
                        onPressedReTry: () async {
                          context.read<UserCubit>().checkUser();
                          context.read<MessageCubit>().fetchData();
                        },
                      ),
                    ),
                  if (state.status.isLoading())
                    Expanded(child: WMessagesLoading()),
                  if (state.status.isLoaded())
                    Expanded(
                      child: WRefreshIndicator(
                        onRefresh: () async {
                          context.read<MessageCubit>().fetchData();
                        },
                        child: LayoutBuilder(
                          builder:
                              (context, constraints) => ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight,
                                  minHeight: constraints.maxHeight,
                                ),
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.vertical,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      24.verticalSpace,
                                      Text(
                                        LocaleKeys.myMessages.tr(),
                                        style: AppTextStyles.size28Bold
                                            .copyWith(color: AppColors.c2E3A59),
                                      ).paddingSymmetric(horizontal: 24.w),
                                      18.verticalSpace,
                                      if ((state.messages?.items ?? [])
                                          .isNotEmpty)
                                        ListView.separated(
                                          itemCount:
                                              state.messages?.items.length ?? 0,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final message =
                                                state.messages?.items[index];
                                            return WMessageItem(
                                              message: message!,
                                              onTap: () {
                                                context
                                                    .read<MessageCubit>()
                                                    .makeMessageRead(index);
                                                context.push(
                                                  Routes.chat,
                                                  extra: message.id,
                                                );
                                              },
                                            );
                                          },
                                          separatorBuilder:
                                              (context, index) => AppDivider(
                                                height: 1.h,
                                                width: 100.sw,
                                                color: AppColors.c000000
                                                    .newWithOpacity(.06),
                                              ).paddingOnly(left: 85.w),
                                        )
                                      else
                                        SizedBox(
                                          height: 600,
                                          width: 100.sw,
                                          child: Center(
                                            child: Column(
                                              spacing: 20.h,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.tray,
                                                  color: AppColors.c2E3A59,
                                                  size: 80.r,
                                                ),
                                                Text(
                                                  LocaleKeys.noMessages.tr(),
                                                  style: AppTextStyles
                                                      .size18Medium
                                                      .copyWith(
                                                        color:
                                                            AppColors.c2E3A59,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (state.isLoading) WLoadingLottie(),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                      ),
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
