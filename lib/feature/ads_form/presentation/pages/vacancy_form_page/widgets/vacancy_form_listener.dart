import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:top_jobs/core/constants/time_delay_cons.dart';
import 'package:top_jobs/core/extentions/color_extension.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_jobs/core/helpers/formatters.dart';
import 'package:top_jobs/export.dart';
import 'package:top_jobs/feature/ads_form/presentation/cubits/vacancy_form_cubit/vacancy_form_cubit.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_form.dart';
import 'package:top_jobs/feature/common/presentation/cubits/category_cubit/category_cubit.dart';
import 'package:top_jobs/feature/common/presentation/pages/w_modal_bottom_sheet_container.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_button.dart';
import 'package:top_jobs/feature/common/presentation/widget/app_header.dart';
import 'package:top_jobs/feature/common/presentation/widget/footer.dart';
import 'package:top_jobs/feature/common/presentation/widget/w_layout.dart';

import '../../../../../../models/address.dart';
import '../../../../data/models/request/vacancy_params.dart';

class VacancyFormListener extends StatefulWidget {
  const VacancyFormListener({
    super.key,
    required VacancyFormControllers formControllers,
    required VacancyFormCustomState formCustomState,
    required VacancyFormKeys formKeys,
  }) : _formKeys = formKeys,
       _formCustomState = formCustomState,
       _formControllers = formControllers;

  final VacancyFormControllers _formControllers;
  final VacancyFormCustomState _formCustomState;
  final VacancyFormKeys _formKeys;

  @override
  State<VacancyFormListener> createState() => _VacancyFormListenerState();
}

class _VacancyFormListenerState extends State<VacancyFormListener>
    with WidgetsBindingObserver {
  final _scrollController = ScrollController();

  VacancyParams _buildVacancyParams() {
    return VacancyParams(
      title: widget._formControllers.titleController.text.trim(),
      categories: widget._formCustomState.categories.map((e) => e.id).toList(),
      city: widget._formCustomState.city,
      address: AddressModel(
        addressLine: widget._formCustomState.address,
        longitude: widget._formCustomState.long,
        latitude: widget._formCustomState.lat,
      ),
      description: widget._formControllers.descriptionController.text.trim(),
      salaryIsNegotiable: widget._formCustomState.salaryNegotiable,
      salaryMin: widget._formControllers.minSalaryController.text.replaceAll(
        " ",
        '',
      ),
      salaryMax: widget._formControllers.maxSalaryController.text.replaceAll(
        " ",
        '',
      ),
      skills: widget._formControllers.skillsController.text.trim(),
      employmentType: widget._formCustomState.employmentType,
      phoneNumber: widget._formControllers.phoneNumberController.text
          .trim()
          .replaceAll(" ", ''),
      phoneNumber1: widget._formControllers.phoneNumberController1.text
          .trim()
          .replaceAll(" ", ''),
      phoneNumber2: widget._formControllers.phoneNumberController2.text
          .trim()
          .replaceAll(" ", ''),
      phoneNumber3: widget._formControllers.phoneNumberController3.text
          .trim()
          .replaceAll(" ", ''),
      partialJobOpportunity: widget._formCustomState.enablePartTime,
      uploadedImages: widget._formCustomState.images,
      workTime:
          widget._formControllers.startTimeController.text.isNotEmpty &&
                  widget._formControllers.endTimeController.text.isNotEmpty
              ? "${widget._formControllers.startTimeController.text.trim()}-${widget._formControllers.endTimeController.text.trim()}"
              : null,
      whoCanRespond:
          widget._formCustomState.withOutFullResume
              ? "without full resume"
              : "",
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch (state) {
        case AppLifecycleState.resumed:
          log("App RESUMED");
          break;
        case AppLifecycleState.inactive:
          log("App INACTIVE");
          break;
        case AppLifecycleState.paused:
          log("App PAUSED → shu yerda draft saqlash mumkin");
          context.read<VacancyFormCubit>().saveVacancyParamsStorage(
            _buildVacancyParams(),
          );
          break;
        case AppLifecycleState.detached:
          log("App DETACHED");
          break;
        case AppLifecycleState.hidden:
          log("App HIDDEN");
          context.read<VacancyFormCubit>().saveVacancyParamsStorage(
            _buildVacancyParams(),
          );

          break;
      }
    });
  }

  VacancyFormState? _previousState;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VacancyFormCubit, VacancyFormState>(
      listenWhen: (previous, current) {
        _previousState = previous;
        return true;
      },
      listener: (context, state) {
        if (state.gptSt.isLoading()) {
          _scrollController.jumpTo(0);
        }
        if (state.gptSt.isLoaded() && !_previousState!.gptSt.isLoaded()) {
          widget._formControllers.titleController.text =
              state.vacancyBody?.result.title ?? '';
          widget._formControllers.descriptionController.text =
              widget._formControllers.gptController.text;
          widget._formControllers.minSalaryController.text =
              Formatters.moneyFormat("${state.vacancyBody?.result.salaryMin}");
          widget._formControllers.maxSalaryController.text =
              Formatters.moneyFormat("${state.vacancyBody?.result.salaryMax}");
          // widget._formControllers.skillsController.text =
          //     state.vacancyBody?.skills.join(',') ?? '';
          (context.read<CategoryCubit>().state.categories?.items ?? []).forEach(
            (e) {
              if (e.id == state.vacancyBody?.result.category?.id) {
                if (!widget._formCustomState.categories.contains(e)) {
                  widget._formCustomState.categories.add(e);
                }
              }
            },
          );
          widget._formControllers.categoriesController.text = widget
              ._formCustomState
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
        if (state.continueUnpublishedAds &&
            !_previousState!.continueUnpublishedAds) {
          widget._formControllers.titleController.text =
              state.params?.title ?? '';
          widget._formControllers.gptController.text =
              state.params?.description ?? '';
          widget._formControllers.descriptionController.text =
              state.params?.description ?? '';
          if ((state.params?.salaryMin ?? '').isNotEmpty) {
            widget
                ._formControllers
                .minSalaryController
                .text = Formatters.moneyFormat("${state.params?.salaryMin}");
          }
          widget._formCustomState.salaryNegotiable =
              state.params?.salaryIsNegotiable ?? false;
          if ((state.params?.salaryMax ?? '').isNotEmpty) {
            widget
                ._formControllers
                .maxSalaryController
                .text = Formatters.moneyFormat("${state.params?.salaryMax}");
          }
          if ((state.params?.skills ?? '').isNotEmpty) {
            widget._formControllers.skillsController.text =
                state.params?.skills ?? '';
          }
          widget._formCustomState.city = state.params?.city;
          widget._formCustomState.address = state.params?.address?.addressLine;
          widget._formCustomState.lat = state.params?.address?.latitude;
          widget._formCustomState.long = state.params?.address?.longitude;
          if (state.params?.whoCanRespond == 'without full resume') {
            widget._formCustomState.withOutFullResume = true;
          }
          widget._formCustomState.enablePartTime =
              state.params?.partialJobOpportunity ?? false;
          widget._formCustomState.employmentType = state.params?.employmentType;
          if ((state.params?.workTime ?? '').isNotEmpty) {
            widget._formControllers.startTimeController.text =
                state.params?.workTime!.split('-').first ?? '';
          }
          if ((state.params?.workTime ?? '').isNotEmpty) {
            widget._formControllers.endTimeController.text =
                state.params?.workTime!.split('-').last ?? '';
          }
          if ((state.params?.phoneNumber ?? "").isNotEmpty) {
            widget
                ._formControllers
                .phoneNumberController
                .text = Formatters.formatUzbekPhone(state.params!.phoneNumber!);
          }

          (context.read<CategoryCubit>().state.categories?.items ?? []).forEach(
            (e) {
              if ((state.params?.categories ?? []).contains(e.id)) {
                if (!widget._formCustomState.categories.contains(e)) {
                  widget._formCustomState.categories.add(e);
                }
              }
            },
          );
          widget._formControllers.categoriesController.text = widget
              ._formCustomState
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

          ////
        }

        if (state.gptSt.isError()) {
          widget._formControllers.descriptionController.text =
              widget._formControllers.gptController.text;
        }
        if (state.gptDesSt.isLoading()) {
          _scrollController.animateTo(
            670,
            duration: TimeDelayCons.durationMill300,
            curve: Curves.easeInOut,
          );
        }

        if (state.gptDesSt.isLoaded() &&!_previousState!.gptDesSt.isLoaded()) {
          String description = state.vacancyDesc ?? ''.replaceAll("**", '');
          description = description.replaceAll("**", '');
          widget._formControllers.descriptionController.text = description;
          setState(() {});
        }

        if (state.formSt.isLoaded() && !_previousState!.formSt.isLoaded()) {
          context.pushReplacement("/vacancy-view?id=${state.vacancy?.id}");
        }
      },
      builder: (context, state) {
        return _buildBody(
          formController: widget._formControllers,
          formCustomState: widget._formCustomState,
          formKeys: widget._formKeys,
          state: state,
        );
      },
    );
  }

  Widget _buildBody({
    required VacancyFormControllers formController,
    required VacancyFormCustomState formCustomState,
    required VacancyFormKeys formKeys,
    required VacancyFormState state,
  }) {
    return WLayout(
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: Column(
          children: [
            AppHeader(isPopAvailable: true),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  WVacancyForm(
                    formController: formController,
                    formCustomState: formCustomState,
                    formKeys: formKeys,
                    state: state,
                  ),
                  20.verticalSpace,
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WVacancyDraftBottomSheet extends StatelessWidget {
  const WVacancyDraftBottomSheet({super.key, required this.onTappedContinue});

  final VoidCallback onTappedContinue;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isDismissible: false,
      useRootNavigator: false,
      isScrollControlled: false,

      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          color: AppColors.cFFFFFF,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
          child: SafeArea(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.cFFFFFF,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                children: [
                  11.verticalSpace,
                  WModalSheetDecoratedContainer(),
                  22.verticalSpace,
                  Text(
                    LocaleKeys.youHaveUnPublishedAd.tr(),
                    style: AppTextStyles.size24Bold.copyWith(
                      color: AppColors.c2E3A59,
                    ),
                  ),
                  10.verticalSpace,
                  Text(
                    LocaleKeys.didYouWantToContinueAd.tr(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.size18Medium.copyWith(
                      color: AppColors.c333333,
                    ),
                  ),
                  40.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      width: 100.sw,
                      onPressed: onTappedContinue,
                      text: LocaleKeys.continueAd.tr(),
                      color: AppColors.c2E3A59,
                      textStyle: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                  20.verticalSpace,
                  SizedBox(
                    height: 50.h,
                    child: AppButton(
                      width: 100.sw,
                      onPressed: () {
                        context.pop();
                      },
                      text: LocaleKeys.createNewAd.tr(),
                      textStyle: AppTextStyles.size17Medium.copyWith(
                        color: AppColors.c2E3A59,
                      ),
                      color: AppColors.c2E3A59.newWithOpacity(.12),
                    ),
                  ),
                  40.verticalSpace,
                ],
              ).paddingSymmetric(horizontal: 18),
            ),
          ),
        ),
      ],
    );
  }
}
