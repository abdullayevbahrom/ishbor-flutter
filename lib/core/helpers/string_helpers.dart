sealed class StringHelpers {
  StringHelpers._();

  static String capitalizeFirst(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }

  static String extractStreet(String input) {
    final parts = input.split(',').map((e) => e.trim()).toList();
    if (parts.length > 2) {
      return parts.sublist(2).join(', ');
    }
    return '';
  }

  static String extractCity(String input) {
    final parts = input.split(',').map((e) => e.trim()).toList();
    if (parts.length >= 2) {
      return parts[1];
    }
    return '';
  }
}
