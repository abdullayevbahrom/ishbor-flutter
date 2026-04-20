import 'dart:async';
import 'dart:ui';

class Debounce {
  Timer? _timer;

  void run(VoidCallback action, [int milliseconds = 1000]) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void cancel() {
    _timer?.cancel();
  }
}
