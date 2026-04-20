import 'package:flutter/cupertino.dart';

class ScrollControllerHelpers{
  void scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        alignment: 0.2,
      );
    }
  }

  void scrollToFirstError(List<GlobalKey<FormFieldState>> keys) {
    for (final key in keys) {
      if (key.currentState?.hasError ?? false) {
        scrollToKey(key);
        break;
      }
    }
  }


}