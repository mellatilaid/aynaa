import 'package:flutter/material.dart';

import '../../../../../../core/widgets/custom_rounded_button_with_title.dart';

class UplaodLessonMediaButtonSection extends StatelessWidget {
  const UplaodLessonMediaButtonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
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
