import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../../core/classes/pick_file.dart';
import '../../../../../../core/widgets/custom_rounded_button_with_title.dart';
import 'uplaod_lesson_button_bloc_builder.dart';

class UplaodLessonMediaButtonSection extends StatefulWidget {
  final TextEditingController lessonContent;
  const UplaodLessonMediaButtonSection({
    super.key,
    required this.lessonContent,
  });

  @override
  State<UplaodLessonMediaButtonSection> createState() =>
      _UplaodLessonMediaButtonSectionState();
}

class _UplaodLessonMediaButtonSectionState
    extends State<UplaodLessonMediaButtonSection> {
  final filePickerHelper = FilePickerHelper();
  bool isMediaUpladed = false;
  File? _file;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: isMediaUpladed
          ? UploadLessonButtonBuilder(lessonContent: widget.lessonContent)
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedButtonWithTitle(
                  iconData: Icons.file_copy,
                  iconName: 'ملف',
                  onTap: () async {
                    _file = await filePickerHelper
                        .pickFile(allowedExtensions: ['pdf']);
                    if (_file != null) {
                      setState(() {
                        isMediaUpladed = true;
                      });
                      print("Picked file: ${_file!.path}");
                    }
                  },
                ),
                RoundedButtonWithTitle(
                  iconData: Icons.image,
                  iconName: 'صورة',
                  onTap: () async {
                    _file = await filePickerHelper.pickImage();
                    if (_file != null) {
                      setState(() {
                        isMediaUpladed = true;
                      });

                      print("Picked file: ${_file!.path}");
                    }
                  },
                ),
                RoundedButtonWithTitle(
                  iconData: Icons.video_call,
                  iconName: 'فيديو',
                  onTap: () async {
                    _file = await filePickerHelper.pickVideo();
                    if (_file != null) {
                      setState(() {
                        isMediaUpladed = true;
                      });
                      print("Picked file: ${_file!.path}");
                    }
                  },
                ),
              ],
            ),
    );
  }
}
