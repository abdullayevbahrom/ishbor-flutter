import 'package:easy_localization/easy_localization.dart';
import 'package:top_jobs/core/constants/locale_keys.g.dart';

sealed class ValidatorHelpers {
  static String? validateField({required String value, message}) {
    if (value.trim().isEmpty) {
      return message != null
          ? "$message ${LocaleKeys.strCannotBeEmpty.tr()}"
          : LocaleKeys.thisFieldCanNotBeEmpty.tr();
    }
    return null;
  }

  static String? validateDescription({required String value, message}) {
    if (value.trim().isEmpty || value.trim().length < 50) {
      return LocaleKeys.characterMustBeAtLeast50.tr();
    }
    return null;
  }

  static String? phoneChecker({required String value, message}) {
    if (value.toString().trim().isEmpty) {
      return message != null
          ? "$message ${LocaleKeys.strCannotBeEmpty.tr()}"
          : LocaleKeys.thisFieldCanNotBeEmpty.tr();
    } else if (value.length != 14) {
      return LocaleKeys.strTheNumberWasEnteredIncorrectly.tr();
    }
    return null;
  }

  static String? passwordChecker({required String value, message}) {
    if (value.toString().trim().isEmpty) {
      return message != null
          ? "$message ${LocaleKeys.strCannotBeEmpty.tr()}"
          : LocaleKeys.thisFieldCanNotBeEmpty.tr();
    } else if (value.toString().trim().length < 6) {
      return LocaleKeys.strPasswordShouldBeLastSix.tr();
    }
    return null;
  }

  static String? validateEmail({required String value, message}) {
    final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+",
    );
    if (value.toString().trim().isEmpty) {
      return message != null
          ? "$message ${LocaleKeys.strCannotBeEmpty.tr()}"
          : LocaleKeys.thisFieldCanNotBeEmpty.tr();
    } else if (!(emailRegExp.hasMatch(value))) {
      return LocaleKeys.strEmailInCorrect.tr();
    }

    return null;
  }

  static String? validatePasswords({
    required String value1,
    required String value2,
  }) {
    if (value1.toString().trim().isEmpty) {
      return "${LocaleKeys.password.tr()} ${LocaleKeys.strCannotBeEmpty.tr()}";
    } else if (value1.toString().trim() != value2.toString().trim()) {
      return LocaleKeys.strPasswordsNotMatch.tr();
    }
    return null;
  }

  static String? validatePhone({required String value, message}) {
    if (value.toString().trim().isEmpty) {
      return message != null
          ? "$message ${LocaleKeys.strCannotBeEmpty.tr()}"
          : LocaleKeys.thisFieldCanNotBeEmpty.tr();
    } else if (value.toString().trim().length < 12) {
      return LocaleKeys.incorrectPhone.tr();
    }
    return null;
  }

  static bool validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber != null &&
        phoneNumber.isNotEmpty &&
        RegExp(r'^[0-9+]+$').hasMatch(phoneNumber)) {
      return true;
    } else {
      return false;
    }
  }
}
