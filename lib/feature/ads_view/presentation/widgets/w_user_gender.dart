import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/data/models/user_update_request.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_radio_box.dart';
import '../../../common/presentation/widget/app_button.dart';

class WUserGender extends StatefulWidget {
  const WUserGender({super.key, required this.onPressedCancel});

  final VoidCallback onPressedCancel;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: AppColors.cFFFFFF,
      shape: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => Wrap(children: [this]),
    );
  }

  @override
  State<WUserGender> createState() => _WUserGenderState();
}

class _WUserGenderState extends State<WUserGender> {
  final _formKey = GlobalKey<FormState>();
  String gender = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      buildWhen: (previous, current) => previous.editSt != current.editSt,
      listenWhen: (previous, current) => previous.editSt != current.editSt,
      listener: (context, state) {
        if (state.editSt.isLoaded()) {
          context.pop();
          widget.onPressedCancel();
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Material(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  11.verticalSpace,
                  WModalSheetDecoratedContainer(),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.selectYourGender.tr(),
                        style: AppTextStyles.size20Bold.copyWith(
                          color: AppColors.c2E3A59,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                          widget.onPressedCancel();
                        },
                        icon: SvgPicture.asset(AppSvg.icCancel),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 16.w),
                  20.verticalSpace,
                  FormField(
                    enabled: true,
                    validator: (value) {
                      if (gender.isEmpty) {
                        return LocaleKeys.strCannotBeEmpty.tr();
                      }
                      return null;
                    },
                    builder: (field) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            onTap: () {
                              setState(() {
                                gender = "male";
                              });
                            },
                            enabled: true,
                            leading: AppRadioBox(value: gender == "male"),
                            title: Text(LocaleKeys.Male.tr()),
                          ),
                          ListTile(
                            onTap: () {
                              setState(() {
                                gender = "female";
                              });
                            },
                            enabled: true,
                            leading: AppRadioBox(value: gender == "female"),
                            title: Text(LocaleKeys.Female.tr()),
                          ),
                          if (field.hasError)
                            Text(
                              LocaleKeys.strCannotBeEmpty.tr(),
                              style: AppTextStyles.size15Medium.copyWith(
                                color: AppColors.cRed,
                              ),
                            ).paddingSymmetric(horizontal: 16.w),
                        ],
                      );
                    },
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      width: 100.sw,
                      isLoading: state.editSt.isLoading(),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<UserCubit>().editUser(
                            user: UserProfileUpdateRequest(gender: gender),
                          );
                        }
                      },
                      text: LocaleKeys.send.tr(),
                      color: AppColors.c2E3A59,
                    ),
                  ).paddingSymmetric(horizontal: 16.w),
                ],
              ),
            ),
          ).paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
        );
      },
    );
  }
}
