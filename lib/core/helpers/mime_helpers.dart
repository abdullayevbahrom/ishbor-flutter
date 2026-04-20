import 'package:mime_type/mime_type.dart';

sealed class MimeTypeHelpers {
  static String? getMimeParts(String path) {
    String? mimeType = mime(path);
    if (mimeType == null) {
      return null;
    }
    return mimeType;
  }
}
