import 'package:flutter/material.dart';

class VacancyFormControllers {
  TextEditingController titleController = TextEditingController();
  TextEditingController categoriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController minSalaryController = TextEditingController();
  TextEditingController maxSalaryController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumberController1 = TextEditingController();
  TextEditingController phoneNumberController2 = TextEditingController();
  TextEditingController phoneNumberController3 = TextEditingController();
  TextEditingController gptController = TextEditingController();

  void dispose() {
    titleController.dispose();
    categoriesController.dispose();
    descriptionController.dispose();
    minSalaryController.dispose();
    maxSalaryController.dispose();
    skillsController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    phoneNumberController.dispose();
    phoneNumberController1.dispose();
    phoneNumberController2.dispose();
    phoneNumberController3.dispose();
    gptController.dispose();
  }
}
