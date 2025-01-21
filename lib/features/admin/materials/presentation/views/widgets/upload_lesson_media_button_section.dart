import 'dart:developer';

import 'package:atm_app/features/admin/materials/presentation/manager/pick_file_cubit/pick_file_cubit.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/upload_media_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/classes/pick_file.dart';
import 'uplaod_lesson_button_bloc_builder.dart';

class UplaodLessonMediaButtonBlocBuilder extends StatefulWidget {
  final TextEditingController lessonContent;

  const UplaodLessonMediaButtonBlocBuilder({
    super.key,
    required this.lessonContent,
  });

  @override
  State<UplaodLessonMediaButtonBlocBuilder> createState() =>
      _UplaodLessonMediaButtonBlocBuilderState();
}

class _UplaodLessonMediaButtonBlocBuilderState
    extends State<UplaodLessonMediaButtonBlocBuilder> {
  final filePickerHelper = FilePickerHelper();
  bool isMediaUpladed = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PickFileCubit, PickFileState>(
      builder: (context, state) {
        if (state is PickFileLoaded) {
          log(state.filePath);
          return UploadLessonButtonBuilder(
            lessonContent: widget.lessonContent,
            filePath: state.filePath,
            isButtonEnabled: true,
          );
        } else if (state is PickFileFailure) {
          return ErrorWidget(state.errMessage);
        } else if (state is PickFileCanceled) {
          return const UploadMediaSection();
        }
        return const UploadMediaSection();
      },
    );
  }
}

/*Future<void> pickFileWithPreview(BuildContext context) async {
  final result = await FilePicker.platform.pickFiles();

  if (result != null && result.files.single.path != null) {
    final file = File(result.files.single.path!);
    final fileType = result.files.single.extension;

    // Show preview dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Preview Uploaded File"),
          content: _buildPreview(file, fileType!),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      print("File confirmed: ${file.path}");
      // Proceed with upload logic
    } else {
      print("File upload canceled.");
    }
  } else {
    print("No file selected.");
  }
}

Widget _buildPreview(File file, String fileType) {
  if (['jpg', 'jpeg', 'png', 'gif'].contains(fileType.toLowerCase())) {
    // Preview image
    return Image.file(file, fit: BoxFit.cover, height: 200, width: 200);
  } else if (['mp4', 'mov', 'avi'].contains(fileType.toLowerCase())) {
    // Show video thumbnail
    return FutureBuilder<Widget>(
      future: generateVideoThumbnail(file.path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data!;
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  } else {
    // Show file name for unsupported types
    return Text("File: ${file.path.split('/').last}");
  }
}

Future<Widget> generateVideoThumbnail(String filePath) async {
  try {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: filePath,
      imageFormat: ImageFormat.JPEG,
      quality: 50,
    );
    if (uint8list != null) {
      return Image.memory(uint8list,
          fit: BoxFit.cover, height: 200, width: 200);
    } else {
      return const Text("Unable to generate thumbnail");
    }
  } on Exception catch (e) {
    log(e.toString());
    return Text(filePath);
  }
}*/
