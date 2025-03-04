import 'dart:developer';

import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/materials/presentation/views/subject_image_preview_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';
import 'add_new_subject_button_bloc_builder.dart';

class AddSubjectBottomSheetBody extends StatefulWidget {
  final SubjectsEntity? existingSubject;
  final bool isEditMode;
  const AddSubjectBottomSheetBody({
    super.key,
    this.existingSubject,
    this.isEditMode = false,
  });
  factory AddSubjectBottomSheetBody.edit({required SubjectsEntity subject}) {
    return AddSubjectBottomSheetBody(
      existingSubject: subject,
      isEditMode: true,
    );
  }

  @override
  State<AddSubjectBottomSheetBody> createState() =>
      _AddSubjectBottomSheetBodyState();
}

class _AddSubjectBottomSheetBodyState extends State<AddSubjectBottomSheetBody> {
  final _subjectTitleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditMode && widget.existingSubject != null) {
      _subjectTitleController.text = widget.existingSubject!.name;
      selectedFile = widget.existingSubject!.localFilePath;
    }
    _subjectTitleController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    final hasChanges = widget.isEditMode
        ? _subjectTitleController.text != widget.existingSubject!.name
        : _subjectTitleController.text.trim().isNotEmpty;

    _isButtonEnabled.value = hasChanges;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectTitleController.dispose();
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
                          log('laid laid $selectedFile' ?? '');
                          _updateButtonState();
                        },
                      ),
                      const SizedBox(height: 16),
                      InvisibleTextField(
                        errMessage: 'يرجى إدخال اسم المادة',
                        controller: _subjectTitleController,
                        hintText: 'اسم المادة',
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
                  return AddNewSubjectButtonBlocBuilder(
                    isEditMode: widget.isEditMode,
                    existingSubject: widget.existingSubject,
                    formKey: _formKey, // Pass the form key to the button
                    subjectTitleController: _subjectTitleController,
                    filePath: selectedFile ?? '',
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
