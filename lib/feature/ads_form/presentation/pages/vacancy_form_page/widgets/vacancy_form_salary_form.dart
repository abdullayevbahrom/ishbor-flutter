import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_salary_form.dart';

import '../../../../../../core/constants/locale_keys.g.dart';
import '../../../cubits/vacancy_form_cubit/vacancy_form_cubit.dart';

class VacancyFormSalaryForm extends StatefulWidget {
  const VacancyFormSalaryForm({
    super.key,
    required this.formCustomState,
    required this.formControllers,
    required this.formKeys,
  });

  final VacancyFormCustomState formCustomState;
  final VacancyFormControllers formControllers;
  final VacancyFormKeys formKeys;

  @override
  State<VacancyFormSalaryForm> createState() => _VacancyFormSalaryFormState();
}

class _VacancyFormSalaryFormState extends State<VacancyFormSalaryForm> {
  late final VoidCallback _minSalaryListener;
  late final VoidCallback _maxSalaryListener;

  @override
  void initState() {
    _initListeners();
    super.initState();
  }

  @override
  void dispose() {
    _removeListeners();
    super.dispose();
  }

  void _initListeners() {
    _minSalaryListener =
        () => _salaryListener(widget.formControllers.minSalaryController);
    _maxSalaryListener =
        () => _salaryListener(widget.formControllers.maxSalaryController);
    widget.formControllers.minSalaryController.addListener(_minSalaryListener);
    widget.formControllers.maxSalaryController.addListener(_maxSalaryListener);
  }

  void _removeListeners() {
    widget.formControllers.minSalaryController.removeListener(_minSalaryListener);
    widget.formControllers.maxSalaryController.removeListener(_maxSalaryListener);
  }

  void _salaryListener(TextEditingController controller) {
    final text = controller.text;

    if (text.isEmpty) {
      return;
    }
    final salary = int.tryParse(text.trim().replaceAll(" ", ''));
    if (salary == null) {
      return;
    }
    if (salary > 50000) {
      setState(() {
        widget.formCustomState.currency = LocaleKeys.sum.tr();
      });
    } else {
      setState(() {
        widget.formCustomState.currency = LocaleKeys.USD.tr();
      });
    }
  }

  void _toggleCurrency() {
    if (widget.formCustomState.currency == LocaleKeys.sum.tr()) {
      setState(() {
        widget.formCustomState.currency = LocaleKeys.USD.tr();
      });
    } else {
      setState(() {
        widget.formCustomState.currency = LocaleKeys.sum.tr();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VacancyFormCubit, VacancyFormState>(
      listener: (context, state) {},
      child: WVacancySalaryForm(
        salaryIsNegotiable: widget.formCustomState.salaryNegotiable,
        currency: widget.formCustomState.currency,
        onTapCurrency: _toggleCurrency,
        checkButtonTapped: () {
          setState(() {
            widget.formCustomState.salaryNegotiable =
                !widget.formCustomState.salaryNegotiable;
          });
        },
        minSalaryController: widget.formControllers.minSalaryController,
        maxSalaryController: widget.formControllers.maxSalaryController,
        skillsController: widget.formControllers.skillsController,
        minSalaryKey: widget.formKeys.minSalaryKey,
        maxSalaryKey: widget.formKeys.maxSalaryKey,
      ),
    );
  }
}
