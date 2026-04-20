import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_svg.dart';
import '../../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../cubits/chat_cubit/chat_cubit.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return SafeArea(
          child: Row(
            spacing: 8.w,
            children: [
              InkWell(
                onTap: () {
                  context.read<ChatCubit>().pickFile(state.message!.id);
                },
                borderRadius: BorderRadius.circular(50.r),
                child: Ink(
                  height: 40.h,
                  width: 40.h,
                  child: SvgPicture.asset(AppSvg.icShare).paddingAll(4.r),
                ),
              ),

              Expanded(
                child: TextFormField(
                  controller: context.read<ChatCubit>().messageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.cFFFFFF,
                    enabled: true,
                    hintText: LocaleKeys.typeSomething.tr(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.r),
                      borderSide: BorderSide(
                        color: AppColors.cFF9914,
                        width: 1.r,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (context
                      .read<ChatCubit>()
                      .messageController
                      .text
                      .trim()
                      .isNotEmpty) {
                    context.read<ChatCubit>().sendMessage({
                      "sender": context.read<UserCubit>().state.user?.id,
                      "type":
                          state.message?.vacancy != null
                              ? "vacancy message"
                              : state.message?.service != null
                              ? "service message"
                              : "task message",
                      "body":
                          context
                              .read<ChatCubit>()
                              .messageController
                              .text
                              .trim(),
                    });
                 context.read<ChatCubit>().scrollToEnd();
                  }
                },
                borderRadius: BorderRadius.circular(20.r),
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.r),
                    color: AppColors.c1A7DFF,
                  ),
                  child: Icon(
                    Icons.arrow_upward_outlined,
                    color: AppColors.cFFFFFF,
                  ).paddingAll(8.r),
                ),
              ),
            ],
          ).paddingOnly(right: 16.w, bottom: 10.h, left: 16.w),
        );
      },
    );
  }
}
