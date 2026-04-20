import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/core/services/storage_service.dart';
import 'package:top_jobs/core/theme/app_colors.dart';
import 'package:top_jobs/core/theme/app_text_styles.dart';
import 'package:top_jobs/core/utils/app_utils.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_error_widget.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_loading.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_menu_container.dart';
import 'package:top_jobs/feature/messages/presentation/pages/chat/widget/chat_header.dart';
import 'package:top_jobs/feature/messages/presentation/pages/chat/widget/chat_header_loading.dart';
import 'package:top_jobs/feature/messages/presentation/pages/chat/widget/chat_input_bar.dart';
import 'package:top_jobs/feature/messages/presentation/pages/chat/widget/chat_loading.dart';
import 'package:top_jobs/feature/messages/presentation/pages/chat/widget/message_bubble.dart';

import '../../../../../injection_container.dart';
import '../../cubits/chat_cubit/chat_cubit.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.messageId});

  final int messageId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatCubit = sl<ChatCubit>();
  int? userId;

  @override
  void initState() {
    initUserId();
    initChat();
    super.initState();
  }

  @override
  void dispose() {
    chatCubit.closeConnection();
    super.dispose();
  }

  Future<void> initUserId() async {
    userId = await sl<StorageService>().fetchUserId();
  }

  void initChat() {
    chatCubit
      ..reset()
      ..initialize()
      ..fetchMessageById(widget.messageId)
      ..fetchMessageReports(widget.messageId)
      ..initChat(widget.messageId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state.status.isLoaded()) {
          initChat();
        }
      },
      child: BlocProvider.value(
        value: chatCubit,
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return WLayout(
              child: Scaffold(
                backgroundColor: AppColors.cFBFBFD,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [AppHeader(isPopAvailable: true),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          if(state.messageSt.isLoaded()) ChatHeader(
                              sender:
                                  userId == state.message?.sender.id
                                      ? state.message?.receiver
                                      : state.message?.sender,
                            ),

                          if(state.messageSt.isLoading()) WChatHeaderLoading(),
                          if (state.fetchSt.isLoading())
                            Expanded(child: WChatLoading()),
                          if (state.fetchSt.isError())
                            WErrorWidget(errorText: state.errorText),
                          if (state.fetchSt.isLoaded())
                            // if ((state.messageRecords?.items ?? []).isEmpty)
                            //   WErrorWidget(
                            //     errorText: LocaleKeys.noMessages.tr(),
                            //   ),
                          Expanded(
                            child: Stack(
                              children: [
                                SingleChildScrollView(
                                  reverse: true,
                                  controller:
                                      context
                                          .read<ChatCubit>()
                                          .scrollController,
                                  child: Column(
                                    children: [
                                      ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        reverse: true,
                                        //controller: chatCubit.scrollController,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 20.h,
                                        ),
                                        itemBuilder: (context, index) {
                                          if (state.isLoadingMore &&
                                              state
                                                      .messageRecords
                                                      ?.items
                                                      .length ==
                                                  index) {
                                            return WLoadingLottie();
                                          }
                                          final messageRecord =
                                              state
                                                  .messageRecords
                                                  ?.items[index];
                                          if (messageRecord != null &&
                                              !chatCubit.messageKey.containsKey(
                                                messageRecord.id,
                                              )) {}
                                          final isFirstMessage =
                                              (state
                                                          .messageRecords
                                                          ?.items
                                                          .length ??
                                                      0) >
                                                  0 &&
                                              index ==
                                                  (state
                                                              .messageRecords
                                                              ?.items
                                                              .length ??
                                                          0) -
                                                      1;
                                          return MessageBubble(
                                            enableFirstMessage: isFirstMessage,
                                            isCurrentUser:
                                                messageRecord?.sender.id ==
                                                context
                                                    .read<UserCubit>()
                                                    .state
                                                    .user
                                                    ?.id,
                                            message: messageRecord,
                                            currentUserId:
                                                context
                                                    .read<UserCubit>()
                                                    .state
                                                    .user!
                                                    .id,
                                            fieldKey:
                                                chatCubit.messageKey[state
                                                    .messageRecords
                                                    ?.items[index]
                                                    .id],
                                            vacancy: state.message?.vacancy,
                                            service: state.message?.service,
                                            task: state.message?.task,
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                AppUtils.hSizedBox16,
                                        itemCount:
                                            (state
                                                    .messageRecords
                                                    ?.items
                                                    .length ??
                                                0) +
                                            (state.isLoadingMore ? 1 : 0),
                                      ),
                                      ListView.separated(
                                        primary: false,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(
                                          right: 16.w,
                                          bottom: 30.h,
                                        ),
                                        itemBuilder: (context, index) {
                                          return AnimatedMenuContainer(
                                            open: true,
                                            duration:
                                                TimeDelayCons.durationMill100,
                                            curve: Curves.ease,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                DecoratedBox(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.cFF9914,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          18.r,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    state
                                                        .sendingMessages[index],
                                                    style: AppTextStyles
                                                        .size15Regular
                                                        .copyWith(
                                                          color:
                                                              AppColors.cFFFFFF,
                                                        ),
                                                  ).paddingSymmetric(
                                                    vertical: 8.h,
                                                    horizontal: 12.w,
                                                  ),
                                                ),
                                                Icon(
                                                  CupertinoIcons.clock,
                                                  color: AppColors.cBDC0C6,
                                                  size: 16,
                                                ).paddingOnly(
                                                  top: 5.h,
                                                  right: 5,
                                                ),
                                              ],
                                            ).paddingOnly(left: 100.w),
                                          );
                                        },
                                        separatorBuilder:
                                            (context, index) =>
                                                AppUtils.hSizedBox16,
                                        itemCount: state.sendingMessages.length,
                                      ),
                                    ],
                                  ),
                                ),
                                if (state.enableDownIcon)
                                  Positioned(
                                    right: 10.w,
                                    bottom: 50.h,
                                    child: FadeInUp(
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          chatCubit.scrollToEnd();
                                        },
                                        backgroundColor: AppColors.cFFFFFF,
                                        shape: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                            50.r,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: AppColors.c2E3A59,
                                            size: 35.r,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          ChatInputBar(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
