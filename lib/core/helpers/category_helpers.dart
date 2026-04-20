import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:top_jobs/feature/common/data/models/category.dart';

sealed class CategoryHelpers {
  CategoryHelpers._();

  static String categoryName(
    List<CategoryModel> categories,
    BuildContext context,
  ) {
    return categories
        .map(
          (e) =>
              e.translations[context.locale.languageCode == 'ru' ? 0 : 1].name,
        )
        .toList()
        .join(',');
  }
}
