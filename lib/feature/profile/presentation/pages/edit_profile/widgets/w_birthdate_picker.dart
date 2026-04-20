import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/helpers/formatters.dart';
import '../../../../../../export.dart';

void showBirthdatePicker(
    BuildContext context,
    TextEditingController birthdayController,
    ) {
  DatePicker.showDatePicker(
    context,
    onCancel: () {
      context.pop();
    },
    onConfirm: (time) {
      birthdayController.text = Formatters.formatDateBirthday(time);
    },
    maxTime: DateTime.now(),
    currentTime:
    birthdayController.text.trim().isNotEmpty
        ? DateFormat('yyyy/MM/dd').parse(birthdayController.text.trim())
        : DateTime(2000),
  );
}