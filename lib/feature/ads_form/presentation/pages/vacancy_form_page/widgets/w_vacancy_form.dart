import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_jobs/core/extentions/padding_extentions.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_address.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_basic_info.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_employment_type.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_photos.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_salary_form.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_who_can_respond.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_submit_button.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_phone_number.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import '../../../widgets/w_ads_description.dart';

class WVacancyForm extends StatelessWidget {
  const WVacancyForm({
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeys.form,
      autovalidateMode: AutovalidateMode.onUserInteraction,

      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Text(
            LocaleKeys.createVacancy.tr(),
            style: AppTextStyles.size28Bold.copyWith(
              color: AppColors.c2E3A59,
            ),
          ).paddingOnly(left: 24.w),
          VacancyFormBasicInfo(
            formControllers: formController,
            formKeys: formKeys,
            formCustomState: formCustomState,
          ),
          VacancyFormAddress(
            formKeys: formKeys,
            formCustomState: formCustomState,
          ),
          WAdsDescription(
            chatGptController: formController.gptController,
            descriptionController: formController.descriptionController,
            descriptionKey: formKeys.descriptionKey,
          ),
          VacancyFormSalaryForm(
            formCustomState: formCustomState,
            formControllers: formController,
            formKeys: formKeys,
          ),
          VacancyFormWhoCanRespondForm(formCustomState: formCustomState),
          VacancyFormEmploymentType(
            formCustomState: formCustomState,
            formControllers: formController,
          ),
          WVacancyPhoneNumber(
            phoneNumberController: formController.phoneNumberController,
            phoneNumberController1: formController.phoneNumberController1,
            phoneNumberController2: formController.phoneNumberController2,
            phoneNumberController3: formController.phoneNumberController3,
          ),
          VacancyFormPhotos(formCustomState: formCustomState),
          VacancyFormSubmitButton(
            state: state,
            formController: formController,
            formCustomState: formCustomState,
            formKeys: formKeys,
          ),
        ],
      ),
    );
  }
}
