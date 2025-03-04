import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/presentation/views/subject_image_preview_builder.dart';
import 'package:atm_app/core/materials/presentation/views/widgets/uplaod_lesson_button_bloc_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddLessonBottomSheetBody extends StatefulWidget {
  final bool isTextOnly;
  final bool isEditMode;
  final LessonEntity? lessonEntity;
  const AddLessonBottomSheetBody({
    super.key,
    this.isTextOnly = true,
    this.isEditMode = false,
    this.lessonEntity,
  });

  factory AddLessonBottomSheetBody.edit({required LessonEntity lesson}) {
    return AddLessonBottomSheetBody(
      lessonEntity: lesson,
      isEditMode: true,
    );
  }

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
    if (widget.isEditMode && widget.lessonEntity != null) {
      _titleController.text = widget.lessonEntity!.name;
      _contentController.text = widget.lessonEntity!.description;
      selectedFile = widget.lessonEntity!.localFilePath;
    }

    _titleController.addListener(() {
      updateButtonState(); // Enable or disable the button
    });
    _contentController.addListener(() {
      updateButtonState(); // Enable or disable the button
    });
  }

  void updateButtonState() {
    final hasTitle = _titleController.text.trim().isNotEmpty;
    final hasContent = _contentController.text.trim().isNotEmpty;
    _isButtonEnabled.value =
        hasTitle && hasContent; // Enable button only if both fields have text
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
                      ImageContentBuilder(
                        filePath: selectedFile,
                        onImageChanged: (newPath) {
                          setState(() => selectedFile = newPath);

                          updateButtonState();
                        },
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
                    formKey: _formKey,
                    isEditMode: widget.isEditMode,
                    filePath: selectedFile ?? '',
                    lessonEntity: widget.lessonEntity,
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
