import 'package:flutter/material.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/w_vacancy_who_respond.dart';

class VacancyFormWhoCanRespondForm extends StatefulWidget {
  const VacancyFormWhoCanRespondForm({
    super.key,
    required this.formCustomState,
  });

  final VacancyFormCustomState formCustomState;

  @override
  State<VacancyFormWhoCanRespondForm> createState() =>
      _VacancyFormWhoCanRespondFormState();
}

class _VacancyFormWhoCanRespondFormState
    extends State<VacancyFormWhoCanRespondForm> {
  void _updateResume() {
    setState(() {
      widget.formCustomState.withOutFullResume =
          !widget.formCustomState.withOutFullResume;
    });
  }

  void _updateEmploymentType(){
    setState(() {
      widget.formCustomState.enablePartTime =
      !widget.formCustomState.enablePartTime;

    });
  }

  @override
  Widget build(BuildContext context) {
    return WVacancyWhoCanRespondForm(
      withFullResume: widget.formCustomState.withOutFullResume,
      enablePartTime: widget.formCustomState.enablePartTime,
      onTappedResume: _updateResume,
      onTappedEmpType:_updateEmploymentType,
    );
  }
}
