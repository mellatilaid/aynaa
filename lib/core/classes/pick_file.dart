import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  Future<XFile?> pickImage() async {
    return _pickFile(fileType: FileType.image);
  }

  /* Future<XFile?> pickVideo() async {
    return _pickFile(fileType: FileType.video);
  }*/

  Future<XFile?> pickFile(
      {FileType fileType = FileType.custom,
      List<String>? allowedExtensions}) async {
    return _pickFile(
      fileType: fileType,
      allowedExtensions: allowedExtensions,
    );
  }

  Future<XFile?> _pickFile({
    required FileType fileType,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowedExtensions: allowedExtensions,
    );

    if (result != null && result.files.single.path != null) {
      return XFile(result.files.single.path!);
    } else {
      print("No file selected.");
      return null;
    }
  }
}
