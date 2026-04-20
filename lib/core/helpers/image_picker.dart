import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<List<File>> pickMultiImage() async {
    List<File> files = [];
    final List<XFile> pickedImages = await _picker.pickMultiImage(
      limit: 4,
      requestFullMetadata: true,
    );

    if (pickedImages.isNotEmpty) {
      for (XFile xFile in pickedImages) {
        files.add(File(xFile.path));
      }
    }

    return files;
  }

  Future<XFile?> pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    return pickedFile;
  }

  List<File> convertToFile(List<XFile> file) {
    List<File> files = [];
    if (file.isNotEmpty) {
      for (XFile xFile in file) {
        files.add(File(xFile.path));
      }
    }
    return files;
  }

  Future<File?> pickDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return null;
    }
  }
}
