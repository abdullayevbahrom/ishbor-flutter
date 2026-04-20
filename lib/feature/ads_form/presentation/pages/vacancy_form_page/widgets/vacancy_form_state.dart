import 'dart:io';

import '../../../../../common/data/models/category.dart';

class VacancyFormCustomState {
  List<CategoryModel> categories = [];
  List<File> images = [];
  bool salaryNegotiable = false;
  bool withOutFullResume = false;
  bool enablePartTime = false;
  String? employmentType;
  String? city;
  String? address;
  double? lat;
  double? long;
  String currency = 'USD';
}
