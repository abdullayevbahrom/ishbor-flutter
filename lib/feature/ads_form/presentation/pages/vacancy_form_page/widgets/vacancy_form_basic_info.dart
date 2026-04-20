import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_controllers.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_keys.dart';
import 'package:top_jobs/feature/ads_form/presentation/pages/vacancy_form_page/widgets/vacancy_form_state.dart';

import '../../../../../profile/presentation/pages/edit_profile/widgets/w_category_picker.dart';
import '../../../widgets/w_ads_basic_information.dart';

class VacancyFormBasicInfo extends StatefulWidget {
  const VacancyFormBasicInfo({
    super.key,
    required this.formControllers,
    required this.formKeys,
    required this.formCustomState,
  });

  final VacancyFormControllers formControllers;
  final VacancyFormKeys formKeys;
  final VacancyFormCustomState formCustomState;

  @override
  State<VacancyFormBasicInfo> createState() => _VacancyFormBasicInfoState();
}

class _VacancyFormBasicInfoState extends State<VacancyFormBasicInfo> {


  Future<void> _updateCategories() async {
    final categories = await WCategoryPicker(
      categories: widget.formCustomState.categories,
    ).show(context);
    if (categories != null) {
      setState(() {
        widget.formCustomState.categories = categories;
      });
      widget.formControllers.categoriesController.text = widget
          .formCustomState
          .categories
          .map((e) {
            return e
                .translations[context.locale.languageCode == 'ru' ? 0 : 1]
                .name;
          })
          .join(',');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WAdsBasicInformation(
      onPressedCategories: _updateCategories,
      categories: widget.formCustomState.categories,
      serviceNameController: widget.formControllers.titleController,
      categoriesController: widget.formControllers.categoriesController,
      serviceNameKey: widget.formKeys.titleKey,
      categoriesKey: widget.formKeys.categoriesKey,
    );
  }
}
