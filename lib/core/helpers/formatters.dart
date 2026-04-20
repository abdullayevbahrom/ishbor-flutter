import 'package:easy_localization/easy_localization.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';
import 'package:top_jobs/core/router/app_routes.dart';
import '../../models/message_record.dart';

class Formatters {
  Formatters._();

  static String formatResetTime(int time) {
    final minutes = time ~/ 60;
    final seconds = time % 60;
    return '${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}';
  }

  static String formatAuthorPhone(String phoneNumber) {
    if (phoneNumber.length < 12) {
      return formatUzbekPhoneNumber("998${phoneNumber}");
    } else {
      return formatUzbekPhoneNumber(phoneNumber);
    }
  }

  static final phoneFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static String formatUzbekPhoneNumber(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');

    if (digits.length != 12 || !digits.startsWith('998')) {
      return input;
    }

    final country = digits.substring(0, 3);
    final code = digits.substring(3, 5);
    final part1 = digits.substring(5, 8);
    final part2 = digits.substring(8, 10);
    final part3 = digits.substring(10, 12);

    return '+$country $code $part1 $part2 $part3';
  }

  static String formatUzbekPhone(String raw) {
    if (raw.length != 9) return raw;

    final regExp = RegExp(r'^(\d{2})(\d{3})(\d{2})(\d{2})$');
    final match = regExp.firstMatch(raw);
    if (match != null) {
      return '${match.group(1)} ${match.group(2)} ${match.group(3)} ${match.group(4)}';
    }

    return raw;
  }

  static String formatDateRu(DateTime date) {
    final formatter = DateFormat(
      "d MMMM y",
      '${navigatorKey.currentContext?.locale.languageCode}',
    );
    return formatter.format(date);
  }

  static String formatDate(DateTime time) {
    final dateTime = DateFormat('dd.MM.yy').format(time);
    return dateTime;
  }

  static String formatDateBirthday(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(date);
  }

  static String formatExpireDate(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy/MM/dd HH:mm');
    return formatter.format(date);
  }

  static String formatMessageDate(DateTime time) {
    final dateTime = DateFormat('dd.MM.yy  HH:mm').format(time);
    return dateTime;
  }

  static String formatTimeOnly(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  static String formatWithSpace({num? salaryMin, num? salaryMax}) {
    final formatter = NumberFormat.currency(
      locale: 'ru_RU',
      symbol: '',
      decimalDigits: 0,
    );
    if (salaryMin == null && salaryMax == null) {
      return LocaleKeys.Negotiable.tr();
    }

    if (salaryMin == 0 && salaryMax == 0) {
      return LocaleKeys.Negotiable.tr();
    }
    if (salaryMin == null) {
      return "${formatter.format(salaryMax).trim()}";
    }

    if (salaryMax == null) {
      return "${formatter.format(salaryMin).trim()}";
    }

    return "${formatter.format(salaryMin)} - ${formatter.format(salaryMax)}";
  }

  static String moneyFormat(String price) {
    if (price.length > 2) {
      var value = price;
      value = value.replaceAll(RegExp(r'\D'), '');
      value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ' ');
      return value;
    }
    return price;
  }

  static String cleanAndReverseAddress(String address) {
    List<String> parts = address.split(',').map((e) => e.trim()).toList();

    parts.removeWhere(
      (part) =>
          part.toLowerCase().contains("oʻzbekiston") ||
          RegExp(r'^\d{6}$').hasMatch(part),
    );

    parts = parts.reversed.toList();

    return parts.join(', ');
  }

  static String timeAgo(DateTime date) {
    final Duration diff = DateTime.now()
        .add(Duration(hours: 5))
        .difference(date);

    if (diff.inSeconds < 60) return secondAgo(diff.inSeconds);
    if (diff.inMinutes < 60) return minuteAgo(diff.inMinutes);
    if (diff.inHours < 24) return hoursAgo(diff.inHours);
    if (diff.inDays < 7) return daysAgo(diff.inDays);
    if (diff.inDays < 30) return weeksAgo((diff.inDays / 7).floor());
    if (diff.inDays < 365) {
      return monthsAgo((diff.inDays / 30).floor());
    }
    return '${(diff.inDays / 365).floor()} ${LocaleKeys.yearAgo.tr()}';
  }

  static String formatSalary({double? salaryMin, double? salaryMax}) {
    if (salaryMin != null &&
        salaryMax != null &&
        salaryMax != 0 &&
        salaryMin != salaryMax) {
      if (salaryMin >= 50000 && salaryMax >= 50000) {
        return "${moneyFormat(salaryMin.toInt().toString())}-${moneyFormat(salaryMax.toInt().toString())} ${LocaleKeys.sum.tr()}";
      } else {
        return "${moneyFormat(salaryMin.toInt().toString())}-${moneyFormat(salaryMax.toInt().toString())} ${LocaleKeys.USD.tr()}";
      }
    } else if (salaryMin != null && salaryMin != 0) {
      if (salaryMin >= 50000) {
        return "${moneyFormat(salaryMin.toInt().toString())} ${LocaleKeys.sum.tr()}";
      } else {
        return "${moneyFormat(salaryMin.toInt().toString())} ${LocaleKeys.USD.tr()}";
      }
    } else {
      return LocaleKeys.salaryIsNegotiable.tr();
    }
  }

  static String translateText({
    required String? uzText,
    required String? ruText,
    required String? defaultText,
  }) {
    final locale = navigatorKey.currentContext?.locale.languageCode;
    if (locale == 'ru') {
      return ruText ?? defaultText ?? ''.replaceAll("*", '');
    } else {
      return uzText ?? defaultText ?? ''.replaceAll("*", "");
    }
  }

  static String formatLastRecord(MessageRecord record) {
    if (record.file == null) {
      return record.body;
    } else {
      if ((record.file?.originalName.length ?? 0) > 20) {
        return "${record.file?.originalName.substring(0, 19)}" +
            '...' +
            "${record.file?.extension}";
      } else {
        return "${record.file?.originalName}";
      }
    }
  }

  static String formatChatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final messageDay = DateTime(date.year, date.month, date.day);

    if (messageDay == today) {
      return " ${LocaleKeys.today.tr()} ${DateFormat("HH:mm").format(date)}";
    } else {
      return DateFormat('dd/MM/yy HH:mm').format(date);
    }
  }

  static String secondAgo(int second) {
    if (second == 1 || second == 21) {
      return LocaleKeys.oneSecondAgo.tr(args: [second.toString()]);
    } else if ((second >= 2 && second <= 4) || (second >= 22 && second <= 24)) {
      return LocaleKeys.fewSecondAgo.tr(args: [second.toString()]);
    } else {
      return LocaleKeys.manySecondAgo.tr(args: [second.toString()]);
    }
  }

  static String minuteAgo(int minute) {
    if (minute == 1 || minute == 21) {
      return LocaleKeys.oneMinuteAgo.tr(args: [minute.toString()]);
    } else if ((minute >= 2 && minute <= 4) || (minute >= 22 && minute <= 24)) {
      return LocaleKeys.fewMinuteAgo.tr(args: [minute.toString()]);
    } else {
      return LocaleKeys.manyMinuteAgo.tr(args: [minute.toString()]);
    }
  }

  static String hoursAgo(int hours) {
    if (hours == 1) {
      return LocaleKeys.oneHourAgo.tr(args: [hours.toString()]);
    } else if (hours >= 2 && hours <= 4 || hours == 22 || hours == 23) {
      return LocaleKeys.fewHourAgo.tr(args: [hours.toString()]);
    } else {
      return LocaleKeys.manyHourAgo.tr(args: [hours.toString()]);
    }
  }

  static String daysAgo(int days) {
    if (days == 1 || days == 21) {
      return LocaleKeys.oneDayAgo.tr(args: [days.toString()]);
    } else if ((days >= 2 && days <= 4) || (days >= 22 && days <= 24)) {
      return LocaleKeys.fewDayAgo.tr(args: [days.toString()]);
    } else {
      return LocaleKeys.manyDayAgo.tr(args: [days.toString()]);
    }
  }

  static String weeksAgo(int week) {
    if (week == 1) {
      return LocaleKeys.oneWeekAgo.tr(args: [week.toString()]);
    } else {
      return LocaleKeys.fewWeekAgo.tr(args: [week.toString()]);
    }
  }

  static String monthsAgo(int moth) {
    if (moth == 1) {
      return LocaleKeys.oneMonthAgo.tr(args: [moth.toString()]);
    } else if (moth >= 2 && moth <= 4) {
      return LocaleKeys.fewMonthAgo.tr(args: [moth.toString()]);
    } else {
      return LocaleKeys.manyMonthAgo.tr(args: [moth.toString()]);
    }
  }
}
