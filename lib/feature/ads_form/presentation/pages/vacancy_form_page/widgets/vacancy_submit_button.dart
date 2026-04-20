import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/models/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/helpers/scrollcontroller_helpers.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../../common/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../../common/presentation/widget/app_button.dart'
    show AppButton;
import '../../../../../common/presentation/widget/w_toasttifications.dart';
import '../../../../data/models/request/vacancy_params.dart';
import '../../../cubits/vacancy_form_cubit/vacancy_form_cubit.dart';

class VacancyFormSubmitButton extends StatelessWidget {
  const VacancyFormSubmitButton({
    super.key,
    required this.formController,
    required this.formCustomState,
    required this.formKeys,
    required this.state,
  });

  final VacancyFormControllers formController;
  final VacancyFormCustomState formCustomState;
  final VacancyFormKeys formKeys;
  final VacancyFormState state;

  VacancyParams _buildVacancyParams() {
    return VacancyParams(
      title: formController.titleController.text.trim(),
      categories: formCustomState.categories.map((e) => e.id).toList(),
      city: formCustomState.city,
      address: AddressModel(
        addressLine: formCustomState.address,
        longitude: formCustomState.long,
        latitude: formCustomState.lat,
      ),
      description: formController.descriptionController.text.trim(),
      salaryIsNegotiable: formCustomState.salaryNegotiable,
      salaryMin: formController.minSalaryController.text.replaceAll(" ", ''),
      salaryMax: formController.maxSalaryController.text.replaceAll(" ", ''),
      skills: formController.skillsController.text.trim(),
      employmentType: formCustomState.employmentType,
      phoneNumber: formController.phoneNumberController.text.trim().replaceAll(
        " ",
        '',
      ),
      phoneNumber1: formController.phoneNumberController1.text
          .trim()
          .replaceAll(" ", ''),
      phoneNumber2: formController.phoneNumberController2.text
          .trim()
          .replaceAll(" ", ''),
      phoneNumber3: formController.phoneNumberController3.text
          .trim()
          .replaceAll(" ", ''),
      partialJobOpportunity: formCustomState.enablePartTime,
      uploadedImages: formCustomState.images,
      workTime:
          formController.startTimeController.text.isNotEmpty &&
                  formController.endTimeController.text.isNotEmpty
              ? "${formController.startTimeController.text.trim()}-${formController.endTimeController.text.trim()}"
              : null,
      whoCanRespond:
          formCustomState.withOutFullResume ? "without full resume" : "",
    );
  }

  void _scrollToFirstError() {
    ScrollControllerHelpers().scrollToFirstError([
      formKeys.titleKey,
      formKeys.categoriesKey,
      formKeys.addressKey,
      formKeys.descriptionKey,
      formKeys.minSalaryKey,
      formKeys.maxSalaryKey,
      formKeys.employmentTypeKey,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 50.h,
            child: AppButton(
              isLoading: state.formSt.isLoading(),
              onPressed: () {
                if (formKeys.form.currentState?.validate()??false) {
                  if ((userState.user?.balance ?? 0) >= 5000 ||
                      (userState.user?.contentCount ?? 0) <
                          (userState.user?.contentLimit ?? 0)) {
                    context.read<VacancyFormCubit>().createVacancy(
                      _buildVacancyParams(),
                    );
                  } else {
                    showPaymentErrorDialog();
                  }
                } else {
                  _scrollToFirstError();
                }
              },
              text: LocaleKeys.createVacancy.tr(),
              textStyle: AppTextStyles.size18Bold.copyWith(
                color: AppColors.cFFFFFF,
              ),
              color: AppColors.cFF9914,
            ),
          ),
        );
      },
    );
  }
}
