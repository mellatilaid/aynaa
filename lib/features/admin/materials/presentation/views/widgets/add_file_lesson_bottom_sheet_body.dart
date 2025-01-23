import 'package:atm_app/features/admin/materials/presentation/views/widgets/lesson_media_content_builder.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/upload_lesson_media_button_section.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddFileLessonBottomSheetBody extends StatefulWidget {
  const AddFileLessonBottomSheetBody({
    super.key,
  });

  @override
  State<AddFileLessonBottomSheetBody> createState() =>
      _AddFileLessonBottomSheetBodyState();
}

class _AddFileLessonBottomSheetBodyState
    extends State<AddFileLessonBottomSheetBody> {
  final _lessonTitleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _lessonTitleController.dispose();
  }

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
              child: Form(
                key: _formKey,
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
        ),
        // Fixed button at the bottom
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: UplaodLessonMediaButtonBlocBuilder(
              lessonContent: _lessonTitleController,
            ),
          ),
        ),
      ],
    );
  }
}
