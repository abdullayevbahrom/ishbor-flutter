import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_listener.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:top_jobs/feature/main/presentation/pages/main_page/widget/animated_menu_container.dart';
import '../../../../common/presentation/widget/app_button.dart';

class VacancyFormPage extends StatefulWidget {
  const VacancyFormPage({super.key, this.params});

  final Map<String, dynamic>? params;

  @override
  State<VacancyFormPage> createState() => _VacancyFormPageState();
}

class _VacancyFormPageState extends State<VacancyFormPage>
    with WidgetsBindingObserver {
  ///Constants
  static const int _maxDescriptionLength = 900;
  late VacancyFormControllers _formControllers;
  late VacancyFormCustomState _formCustomState;
  late VacancyFormKeys _formKeys;
  late final VoidCallback _descriptionControllerListener;

  void _descriptionListener(TextEditingController controller) {
    final text = controller.text;
    if (text.length > _maxDescriptionLength) {
      final newText = text.substring(0, _maxDescriptionLength);
      controller.value = controller.value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  void _initializePhoneNumber() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _formControllers.phoneNumberController.text =
          context.read<UserCubit>().state.user?.phoneNumber ?? '';
      _formControllers.phoneNumberController.text = Formatters.formatUzbekPhone(
        _formControllers.phoneNumberController.text.replaceAll("998", ''),
      );
    });
  }

  void _initializeCategories() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoryCubit>()
        ..reset()
        ..initialize()
        ..fetchCategories();

      if (widget.params?['prompt'] != null) {
        context.read<VacancyFormCubit>().generateVacancyBody(
          widget.params?['prompt'],
        );
      }
    });
  }

  @override
  void initState() {
    _formControllers = VacancyFormControllers();
    _formKeys = VacancyFormKeys();
    _formCustomState = VacancyFormCustomState();
    if (widget.params?['prompt'] != null) {
      _formControllers.gptController.text = widget.params?['prompt'];
      _formControllers.descriptionController.text = widget.params?['prompt'];
    }
    _initializePhoneNumber();
    _setUpControllersListeners();
    _initializeCategories();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _removeControllersListeners();
    _formControllers.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _setUpControllersListeners() {
    _descriptionControllerListener =
        () => _descriptionListener(_formControllers.descriptionController);
    _formControllers.descriptionController.addListener(
      _descriptionControllerListener,
    );
  }

  void _removeControllersListeners() {
    _formControllers.descriptionController.removeListener(
      _descriptionControllerListener,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacancyFormCubit, VacancyFormState>(
      listenWhen: (previous, current) => true,
      listener: (context, state) {
        if (state.continueUnpublishedAds) {
          setState(() {});
        }
      },
      builder: (context, state) {
        if (state.continueUnpublishedAds) {
          _formControllers.titleController.text = state.params?.title ?? '';
          _formControllers.gptController.text = state.params?.description ?? '';
          _formControllers.descriptionController.text =
              state.params?.description ?? '';
          if ((state.params?.salaryMin ?? '').isNotEmpty) {
            _formControllers.minSalaryController.text = Formatters.moneyFormat(
              "${state.params?.salaryMin}",
            );
          }
          _formCustomState.salaryNegotiable =
              state.params?.salaryIsNegotiable ?? false;
          if ((state.params?.salaryMax ?? '').isNotEmpty) {
            _formControllers.maxSalaryController.text = Formatters.moneyFormat(
              "${state.params?.salaryMax}",
            );
          }
          if ((state.params?.skills ?? '').isNotEmpty) {
            _formControllers.skillsController.text = state.params?.skills ?? '';
          }
          _formCustomState.city = state.params?.city;
          _formCustomState.address = state.params?.address?.addressLine;
          _formCustomState.lat = state.params?.address?.latitude;
          _formCustomState.long = state.params?.address?.longitude;
          if (state.params?.whoCanRespond == 'without full resume') {
            _formCustomState.withOutFullResume = true;
          }
          _formCustomState.enablePartTime =
              state.params?.partialJobOpportunity ?? false;
         _formCustomState.employmentType = state.params?.employmentType;
          if ((state.params?.workTime ?? '').isNotEmpty) {
            _formControllers.startTimeController.text =
                state.params?.workTime!.split('-').first ?? '';
          }
          if ((state.params?.workTime ?? '').isNotEmpty) {
          _formControllers.endTimeController.text =
                state.params?.workTime!.split('-').last ?? '';
          }
          if ((state.params?.phoneNumber ?? "").isNotEmpty) {
           _formControllers
                .phoneNumberController
                .text = Formatters.formatUzbekPhone(state.params!.phoneNumber!);
          }

          (context.read<CategoryCubit>().state.categories?.items ?? []).forEach(
            (e) {
              if ((state.params?.categories ?? []).contains(e.id)) {
                if (!_formCustomState.categories.contains(e)) {
                  _formCustomState.categories.add(e);
                }
              }
            },
          );
          _formControllers.categoriesController.text =
              _formCustomState
              .categories
              .map(
                (e) =>
                    e
                        .translations[context.locale.languageCode == 'ru'
                            ? 0
                            : 1]
                        .name,
              )
              .join(',');
        }

        return Stack(
          children: [
            VacancyFormListener(
              formControllers: _formControllers,
              formCustomState: _formCustomState,
              formKeys: _formKeys,
            ),
            Positioned(
              bottom: 40,
              right: 20,
              child: AnimatedMenuContainer(
                open: state.gptSt.isLoading() || state.gptDesSt.isLoading(),
                curve: Curves.ease,
                duration: TimeDelayCons.durationMill400,
                child: SizedBox(
                  height: 62.h,
                  child: AppButton(
                    onPressed: () {},
                    leftIcon: SizedBox(
                      height: 22.r,
                      width: 22.r,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColors.cFF9914,
                        ),
                      ),
                    ).paddingOnly(right: 10.w),
                    text: LocaleKeys.fillFormsForYou.tr(),
                    color: AppColors.cFFFDFB,
                    textStyle: AppTextStyles.size15Medium.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                    shadow: [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 23,
                        color: AppColors.c000000.newWithOpacity(.08),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

/*
 SizedBox(
          height: 62.h,
          child: AppButton(
            width: 100.sw,
            onPressed: () {},
            text: LocaleKeys.fillFormsForYou.tr(),
            color: AppColors.cFFFDFB,
            shadow: [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 23,
                color: AppColors.c000000.newWithOpacity(.08),
              ),
            ],
          ),
        ),
 */
