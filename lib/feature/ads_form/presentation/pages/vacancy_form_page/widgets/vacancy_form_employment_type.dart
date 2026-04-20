import 'package:flutter/material.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_employment_type.dart';

class VacancyFormEmploymentType extends StatefulWidget {
  const VacancyFormEmploymentType({
    super.key,
    required this.formControllers,
    required this.formCustomState,
  });

  final VacancyFormControllers formControllers;
  final VacancyFormCustomState formCustomState;

  @override
  State<VacancyFormEmploymentType> createState() =>
      _VacancyFormEmploymentTypeState();
}

class _VacancyFormEmploymentTypeState extends State<VacancyFormEmploymentType> {
  void _updateEmploymentType(String value) {
    setState(() {
      widget.formCustomState.employmentType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WVacancyEmploymentType(
      value: widget.formCustomState.employmentType,
      onTappedTile: _updateEmploymentType,
      endTime: widget.formControllers.endTimeController,
      startTime: widget.formControllers.startTimeController,
    );
  }
}
