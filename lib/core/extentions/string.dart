extension StringExtension on String {
  String capitalize() {
    return "${substring(0, 1).toUpperCase()}${substring(1)}";
  }

  String truncate(int cutoff, {String character = ''}) {
    return length <= cutoff ? this : '${substring(0, cutoff)}$character';
  }
}
