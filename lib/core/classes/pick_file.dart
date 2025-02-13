import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;

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
      /*   final pickedFilePath = result.files.single.path!;
      log('picked file befor compress is $pickedFilePath and size is ${File(pickedFilePath).lengthSync()}');
      // Compress the image
      final compressedFile = await compressImage(pickedFilePath);
      (compressedFile != null)
          ? log(
              'compressed file is ${compressedFile.path} and size is ${compressedFile.lengthSync()}')
          : null;
      return compressedFile != null ? XFile(compressedFile.path) : null;*/
      return XFile(result.files.single.path!);
    } else {
      print("No file selected.");
      return null;
    }
    return null;
  }

  Future<File?> compressImage(String imagePath) async {
    // Load the image
    File imageFile = File(imagePath);
    final originalImage = img.decodeImage(await imageFile.readAsBytes());

    if (originalImage == null) {
      print("Could not decode image.");
      return null;
    }

    // Resize and compress the image
    img.Image resizedImage = img.copyResize(
      originalImage,
      width: 800,
    ); // Adjust width as needed
    final compressedImageBytes =
        img.encodeJpg(resizedImage, quality: 30); // Set quality (0-100)

    // Overwrite the original file with the compressed image
    await imageFile.writeAsBytes(compressedImageBytes);

    return imageFile; // Return the original file reference
  }
}
