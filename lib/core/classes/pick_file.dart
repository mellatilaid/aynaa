import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  /*Future<File?> pickImage() async {
    return _pickFile(FileType.image);
  }

  Future<File?> pickVideo() async {
    return _pickFile(FileType.video);
  }

  Future<File?> pickFile({List<String>? allowedExtensions}) async {
    return _pickFile(FileType.custom, allowedExtensions: allowedExtensions);
  }*/

  Future<File?> pickFile({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    } else {
      print("No file selected.");
      return null;
    }
  }
}
