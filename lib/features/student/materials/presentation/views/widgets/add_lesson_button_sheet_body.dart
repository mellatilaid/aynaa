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
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    void updateButtonState() {
      final hasTitle = _titleController.text.trim().isNotEmpty;
      final hasContent = _contentController.text.trim().isNotEmpty;
      _isButtonEnabled.value =
          hasTitle && hasContent; // Enable button only if both fields have text
    }

    _titleController.addListener(() {
      updateButtonState(); // Enable or disable the button
    });
    _contentController.addListener(() {
      updateButtonState(); // Enable or disable the button
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Stack(
        children: [
          // Scrollable content
          Padding(
            padding: const EdgeInsets.only(
                bottom: 60.0), // Leave space for the button
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
                        controller: _titleController,
                        hintText: 'عنوان الدرس',
                        maxLines: 1,
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InvisibleTextField(
                        controller: _contentController,
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
                    lessonTitle: _titleController,
                    lessonContent: _contentController,
                  );
                },
                /*child: UploadLessonButtonBuilder(
                          lessonContent: _lessonTitleController),*/
              ),
            ),
          ),
        ],
      ),
    );
  }
}
