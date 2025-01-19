import 'package:atm_app/features/admin/materials/presentation/views/widgets/lesson_media_content_builder.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/upload_lesson_media_button_section.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddLessonBottomSheetBody extends StatefulWidget {
  const AddLessonBottomSheetBody({
    super.key,
  });

  @override
  State<AddLessonBottomSheetBody> createState() =>
      _AddLessonBottomSheetBodyState();
}

class _AddLessonBottomSheetBodyState extends State<AddLessonBottomSheetBody> {
  final _lessonTitleController = TextEditingController();
  String? selectedFile;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable content
        Padding(
          padding:
              const EdgeInsets.only(bottom: 60.0), // Leave space for the button
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LessonMediaContentBuilder(
                    filePath: selectedFile,
                  ),
                  const SizedBox(height: 16),
                  InvisibleTextField(
                    controller: _lessonTitleController,
                    hintText: 'محتوى الدرس',
                    maxLines: 6,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
        // Fixed button at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: UplaodLessonMediaButtonBlocBuilder(
            lessonContent: _lessonTitleController,
            onFileUploaded: onFileUploaded,
          ),
        ),
      ],
    );
  }

  onFileUploaded({required String filePath}) {
    setState(() {
      selectedFile = filePath;
    });
  }
}
