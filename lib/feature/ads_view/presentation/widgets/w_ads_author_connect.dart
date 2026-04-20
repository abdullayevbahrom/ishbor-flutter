import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/ads_view/presentation/cubits/ads_contact_cubit/ads_contact_cubit.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_ads_report.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_author_phone_numbers.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_send_message_user.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_user_about_me.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_user_birthday.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_user_city.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_user_email.dart';
import 'package:top_jobs/feature/ads_view/presentation/widgets/w_user_gender.dart';
import 'package:top_jobs/feature/auth/presentation/pages/login_page/login_page.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';

import '../../../../injection_container.dart';
import '../../../../models/user.dart';
import '../../../common/presentation/cubits/ask_question_cubit/ask_question_cubit.dart';
import '../../../common/presentation/widget/app_button.dart';

class WAdsAuthorConnect extends StatefulWidget {
  const WAdsAuthorConnect({
    super.key,
    required this.customerId,
    this.vacancyId,
    this.serviceId,
    this.taskId,
    required this.phoneNumbers,
    this.onPressedApply,
    this.hasUserRequest,
  });

  final List<String?> phoneNumbers;
  final int customerId;
  final int? vacancyId;
  final int? serviceId;
  final int? taskId;
  final VoidCallback? onPressedApply;
  final bool? hasUserRequest;

  @override
  State<WAdsAuthorConnect> createState() => _WAdsAuthorConnectState();
}

class _WAdsAuthorConnectState extends State<WAdsAuthorConnect> {
  bool get userLogged =>
      navigatorKey.currentContext?.read<UserCubit>().state.hasToken ?? false;

  User? get currentUser =>
      navigatorKey.currentContext?.read<UserCubit>().state.user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AskQuestionCubit, AskQuestionState>(
      builder: (context, state) {
        return Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 20.w,
              children: [
                Expanded(
                  child: BlocProvider(
                    create:
                        (context) =>
                            sl<AdsContactCubit>()..fetchCountOfPhoneReq(),
                    child: BlocConsumer<AdsContactCubit, AdsContactState>(
                      listener: (context, state) {
                        showPhoneNumber() {
                          WAuthorPhoneNumbers(
                            id:
                                widget.vacancyId ??
                                widget.serviceId ??
                                widget.taskId ??
                                1,
                            type:
                                widget.vacancyId != null
                                    ? "vacancy"
                                    : widget.serviceId != null
                                    ? "service"
                                    : "task",
                            phoneNumbers: [
                              state.contact?.phoneNumber,
                              state.contact?.phoneNumber1,
                              state.contact?.phoneNumber2,
                              state.contact?.phoneNumber3,

                              // state.contact?.telegram
                            ],
                          ).show(context);
                        }

                        if (state.status.isLoaded()) {
                          if (state.countOfPhoneReq % 3 == 0) {
                            if (currentUser?.birthDay == null) {
                              WUserBirthday(
                                onPressedCancel: () {
                                  showPhoneNumber();
                                },
                              ).show(context);
                            } else if (currentUser?.gender == null) {
                              WUserGender(
                                onPressedCancel: () {
                                  showPhoneNumber();
                                },
                              ).show(context);
                            } else if (currentUser?.city == null) {
                              WUserCity(
                                onPressedCancel: () {
                                  showPhoneNumber();
                                },
                              ).show(context);
                            } else if ((currentUser?.aboutMe ?? '').isEmpty) {
                              WUserAboutMe(
                                onPressedCancel: () {
                                  showPhoneNumber();
                                },
                              ).show(context);
                            } else if ((currentUser?.email ?? '').isEmpty) {
                              WUserEmail(
                                onPressedCancel: () {
                                  showPhoneNumber();
                                },
                              ).show(context);
                            } else {
                              showPhoneNumber();
                            }
                          } else {
                            showPhoneNumber();
                          }
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 50.h,
                          child: AppButton(
                            isLoading: state.status.isLoading(),
                            onPressed: () {
                              if (userLogged) {
                                if (widget.vacancyId != null) {
                                  context
                                      .read<AdsContactCubit>()
                                      .fetchVacancyContact(widget.vacancyId!);
                                }

                                if (widget.serviceId != null) {
                                  context
                                      .read<AdsContactCubit>()
                                      .fetchServiceContact(widget.serviceId!);
                                }
                                if (widget.taskId != null) {
                                  context
                                      .read<AdsContactCubit>()
                                      .fetchTaskContact(widget.taskId!);
                                }
                              } else {
                                LoginPage().show(context);
                              }
                            },
                            // isLoading: state.status,
                            textStyle: AppTextStyles.size17Medium.copyWith(
                              color: AppColors.cFFFFFF,
                            ),
                            color: AppColors.c15CF74,
                            text: LocaleKeys.call.tr(),
                            shadow: [
                              BoxShadow(
                                color: AppColors.c15CF74.newWithOpacity(.4),
                                offset: const Offset(0, 4),
                                blurRadius: 15.r,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 50.h,
                    child: AppButton(
                      isAvailable: !(widget.hasUserRequest ?? false),
                      onPressed: () {
                        if (userLogged) {
                          widget.taskId != null
                              ? widget.hasUserRequest ?? false
                                  ? null
                                  : widget.onPressedApply!()
                              : WSendMessageUser(
                                title:
                                    widget.vacancyId != null
                                        ? LocaleKeys.askAQuestionAboutAJob.tr()
                                        : LocaleKeys.askQuestionAboutService
                                            .tr(),
                                receiverId: widget.customerId,
                                vacancyId: widget.vacancyId,
                                taskId: widget.taskId,
                                serviceId: widget.serviceId,
                              ).show(context);
                        } else {
                          LoginPage().show(context);
                        }
                      },
                      textStyle: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                      color:
                          (widget.hasUserRequest ?? false)
                              ? AppColors.cFF9914.newWithOpacity(.3)
                              : AppColors.cFF9914,
                      text:
                          widget.taskId != null
                              ? LocaleKeys.applyRequest.tr()
                              : LocaleKeys.write.tr(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
              child: AppButton(
                width: 100.sw,
                radius: 12,
                onPressed: () {
                  if (userLogged) {
                    WAdsReport(
                      // userId: customerId,
                      vacancyId: widget.vacancyId,
                      serviceId: widget.serviceId,
                      taskId: widget.taskId,
                    ).show(context);
                  } else {
                    LoginPage().show(context);
                  }
                },
                text: LocaleKeys.complain.tr(),
                verticalPadding: 14.h,
                textStyle: AppTextStyles.size17Medium.copyWith(
                  color: AppColors.cFF3A44,
                ),
                color: AppColors.cFF3A44.newWithOpacity(.1),
              ),
            ),
          ],
        );
      },
    ).paddingSymmetric(horizontal: 16.w);
  }
}
