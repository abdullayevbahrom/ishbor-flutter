import 'dart:ui';

sealed class StatusHelpers {
 static Color getColor(String status) {
    switch (status) {
      case 'pending':
        return Color(0xff595f54);

      case 'moderation':
        return Color(0xffc79413);

      case 'need edit':
        return Color(0xffC7B813);

      case 'rejected':
        return Color(0xffba3e04);

      case 'deactivated':
        return Color(0xffF23838);

      case 'deleted':
        return Color(0xffFF0000);

      case 'published':
        return Color(0xff3A7C00);

      case 'finished':
        return Color(0xff5bb400);

      default:
        return Color(0xff888888);
    }
  }
}
