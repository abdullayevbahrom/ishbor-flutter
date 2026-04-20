import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/locale_keys.g.dart';
import '../../../../core/theme/app_text_styles.dart';

class WErrorWidget extends StatelessWidget {
  const WErrorWidget({super.key, this.errorText});

  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorText ?? LocaleKeys.unExpectedError.tr(),
        style: AppTextStyles.size15Medium,
      ),
    );
  }
}
