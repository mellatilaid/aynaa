import 'package:flutter/material.dart';

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
  bool isMediaUpladed = true;
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
                    iconData: Icons.file_copy, iconName: 'ملف', onTap: () {}),
                RoundedButtonWithTitle(
                    iconData: Icons.image, iconName: 'صورة', onTap: () {}),
                RoundedButtonWithTitle(
                  iconData: Icons.video_call,
                  iconName: 'فيديو',
                  onTap: () {},
                ),
              ],
            ),
    );
  }
}
