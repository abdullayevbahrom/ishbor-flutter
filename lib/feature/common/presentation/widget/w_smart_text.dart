import 'package:flutter/cupertino.dart';
import 'package:top_jobs/core/constants/app_locale_keys.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SmartText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const SmartText({
    Key? key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  // String _processText(String rawText) {
  //   final lines = rawText.split('\n');
  //   for (int i = 1; i < lines.length && i < 4; i++) {
  //     if (lines[i].trim().isEmpty) {
  //       return lines.first.trim();
  //     }
  //   }
  //   return rawText.trim();
  // }

  String _processText(String rawText) {
    final lines =
        rawText
            .split('\n') // qatordan bo‘lamiz
            .map((e) => e.trim()) // ortiqcha probellarni olib tashlaymiz
            .where(
              (line) => line.isNotEmpty,
            ) // bo‘sh qatorlarni chiqarib tashlaymiz
            .toList();

    return lines
        .join('\n')
        .replaceAll('\n', ' '); // qolganlarini qayta birlashtiramiz
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _processText(text),
      style:
          style ??
          AppTextStyles.size15Regular.copyWith(
            color: AppColors.c888888,
            fontFamily: AppLocaleKeys.fontSFProRegular,
          ),
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines ?? 4,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
