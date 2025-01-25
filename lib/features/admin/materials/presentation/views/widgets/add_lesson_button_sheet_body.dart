import 'package:atm_app/features/admin/materials/presentation/views/widgets/lesson_media_content_builder.dart';
import 'package:atm_app/features/admin/materials/presentation/views/widgets/uplaod_lesson_button_bloc_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddLessonBottomSheetBody extends StatefulWidget {
  final bool isTextOnly;
  const AddLessonBottomSheetBody({
    super.key,
    required this.isTextOnly,
  });

  @override
  State<AddLessonBottomSheetBody> createState() =>
      _AddLessonBottomSheetBodyState();
}

class _AddLessonBottomSheetBodyState extends State<AddLessonBottomSheetBody> {
  final _lessonTitleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lessonTitleController.addListener(() {
      final hasText = _lessonTitleController.text.trim().isNotEmpty;
      _isButtonEnabled.value = hasText; // Enable or disable the button
    });
  }

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
                      hintText: 'محتوى الدرس ',
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
              child: ValueListenableBuilder(
                valueListenable: _isButtonEnabled,
                builder: (context, value, child) {
                  return UploadLessonButtonBuilder(
                    isButtonEnabled: value,
                    lessonContent: _lessonTitleController,
                  );
                },
                /*child: UploadLessonButtonBuilder(
                        lessonContent: _lessonTitleController),*/
              ),
            )),
      ],
    );
  }
}
