import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/feature/auth/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:top_jobs/feature/auth/presentation/pages/name_page/name_page.dart';

import '../../../../../export.dart';
import '../../../../common/presentation/widget/app_button.dart';
import '../../../../common/presentation/widget/w_radio_list_tile.dart';

class UserTypePage extends StatelessWidget {
  UserTypePage({super.key, required this.phoneNumber});

  final String phoneNumber;

  show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              height: 350.h,
              child: this,
            ), // Your LoginPage widget
          ),
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor: AppColors.cFFFFFF,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20.r),
          left: Radius.circular(20.r),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            width: 100.sw,
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: AppColors.c000000.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 8.r,
                ),
              ],
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(20.r),
                right: Radius.circular(20.r),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 36.h),
                Text(
                  LocaleKeys.whatIsYourAction.tr(),
                  style: AppTextStyles.size28Bold.copyWith(
                    color: AppColors.c2E3A59,
                  ),
                ),
                SizedBox(height: 14.h),

                FormField(
                  validator: (value) {
                    if (state.type == null) {
                      return LocaleKeys.strCannotBeEmpty.tr();
                    }
                    return null;
                  },
                  builder: (field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WRadioListTile(
                          title: LocaleKeys.iNeedJob.tr(),
                          value: state.type == 'worker',
                          onTap: () {
                            context.read<AuthCubit>().updateType('worker');
                          },
                        ),
                        WRadioListTile(
                          title: LocaleKeys.iNeedWorker.tr(),
                          value: state.type == 'employer',
                          onTap: () {
                            context.read<AuthCubit>().updateType('employer');
                          },
                        ),

                        if (state.type == null)
                          Text(
                            LocaleKeys.thisFieldCanNotBeEmpty.tr(),
                            style: AppTextStyles.size14Medium.copyWith(
                              color: AppColors.cRed,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 50.h,
                  child: AppButton(
                    width: 100.sw,
                    textStyle: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.cFFFFFF
                    ),
                    isLoading: false,
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.pop();
                        NamePage(
                          phoneNumber: phoneNumber,
                          userType: state.type!,
                        ).show(context);
                      }
                    },
                    text: LocaleKeys.next.tr(),
                    rightIcon: Icon(
                      Icons.arrow_forward,
                      color: AppColors.cFFFFFF,
                    ),
                    color: AppColors.cFF9914,
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w),
          ),
        );
      },
    );
  }
}
