import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/add_exam_button_bloc_builder.dart';
import 'package:atm_app/features/common/versions/presentation/views/subject_image_preview_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddExamBottomSheetBody extends StatefulWidget {
  final bool isEditMode;
  final ExamEntity? exam;
  const AddExamBottomSheetBody({
    super.key,
    this.exam,
    this.isEditMode = false,
  });

  factory AddExamBottomSheetBody.edit({required ExamEntity exam}) {
    return AddExamBottomSheetBody(exam: exam, isEditMode: true);
  }

  @override
  State<AddExamBottomSheetBody> createState() => _AddExamBottomSheetBodyState();
}

class _AddExamBottomSheetBodyState extends State<AddExamBottomSheetBody> {
  final _titleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditMode && widget.exam != null) {
      _titleController.text = widget.exam!.title;
      selectedFile = widget.exam!.localFilePath;
    }
    _titleController.addListener(() {
      _isButtonEnabled.value = hasText; // Enable or disable the button
    });
  }

  bool get hasText {
    final trimmedText = _titleController.text.trim();
    return widget.isEditMode
        ? (trimmedText.isNotEmpty && trimmedText != widget.exam!.title) ||
            (selectedFile != null)
        : (trimmedText.isNotEmpty && selectedFile != null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.45,
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
                        },
                      ),
                      const SizedBox(height: 16),
                      InvisibleTextField(
                        errMessage: 'يرجى إدخال عنوان الامتحان',
                        controller: _titleController,
                        hintText: 'عنوان الامتحان',
                        textStyle: Theme.of(context).textTheme.headlineSmall,
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
                  return AddExamButtonBlocBuilder(
                    isButtonEnabled: _isButtonEnabled.value,
                    filePath: selectedFile ?? '',
                    isEditMode: widget.isEditMode,
                    formKey: _formKey, // Pass the form key to the button
                    titleController: _titleController,
                    exam: widget.exam,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*class AddImageNoteBottomSheetBody extends StatefulWidget {
  const AddImageNoteBottomSheetBody({super.key});

  @override
  State<AddImageNoteBottomSheetBody> createState() =>
      _AddImageNoteBottomSheetBodyState();
}

class _AddImageNoteBottomSheetBodyState
    extends State<AddImageNoteBottomSheetBody> {
  final TextEditingController _subjectTitleController = TextEditingController();
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form key for validation

  @override
  void dispose() {
    _subjectTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 28,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Text field for subject title
              InvisibleTextField(
                errMessage: 'يرجى إدخال اسم المادة',
                controller: _subjectTitleController,
                hintText: 'اسم المادة',
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              // Button to add the subject
              AddNewSubjectButtonBlocBuilder(
                formKey: _formKey, // Pass the form key to the button
                subjectTitleController: _subjectTitleController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
