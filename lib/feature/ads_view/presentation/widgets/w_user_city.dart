import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/helpers/validators.dart';
import 'package:top_jobs/core/theme/app_svg.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/common/data/models/user_update_request.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_text_form_field.dart';
import 'package:top_jobs/feature/profile/presentation/pages/edit_profile/widgets/w_city_picker.dart';
import '../../../common/presentation/widget/app_button.dart';

class WUserCity extends StatefulWidget {
  const WUserCity({super.key, required this.onPressedCancel});

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
  State<WUserCity> createState() => _WUserCityState();
}

class _WUserCityState extends State<WUserCity> {
  late TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
                        LocaleKeys.selectYourCity.tr(),
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
                  ),
                  25.verticalSpace,
                  AppTextFormField(
                    onTap: () {
                      WCityPicker(cityController: _controller).show(context);
                    },
                    fillColor: AppColors.cFFFFFF,
                    hintText: LocaleKeys.enterCity.tr(),
                    controller: _controller,
                    keyBoardType: TextInputType.text,
                    validator: (value) {
                      return ValidatorHelpers.validateField(value: value!);
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
                            user: UserProfileUpdateRequest(
                              city: _controller.text.trim(),
                            ),
                          );
                        }
                      },
                      text: LocaleKeys.send.tr(),
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  40.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 16.w),
            ),
          ).paddingOnly(bottom: MediaQuery.viewInsetsOf(context).bottom),
        );
      },
    );
  }
}
