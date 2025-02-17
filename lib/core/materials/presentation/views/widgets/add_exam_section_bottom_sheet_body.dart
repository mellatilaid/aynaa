import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_exam_section_button_bloc_builder.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/exam_section_image_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddExamSectionBottomSheetBody extends StatefulWidget {
  const AddExamSectionBottomSheetBody({
    super.key,
  });

  @override
  State<AddExamSectionBottomSheetBody> createState() =>
      _AddExamSectionBottomSheetBodyState();
}

class _AddExamSectionBottomSheetBodyState
    extends State<AddExamSectionBottomSheetBody> {
  final _titleController = TextEditingController();
  String? selectedFile;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _isButtonEnabled = ValueNotifier<bool>(false);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController.addListener(() {
      final hasText = _titleController.text.trim().isNotEmpty;
      _isButtonEnabled.value = hasText; // Enable or disable the button
    });
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
                      ExamSectionImageContentBuilder(
                        filePath: selectedFile,
                      ),
                      const SizedBox(height: 16),
                      InvisibleTextField(
                        errMessage: 'يرجى إدخال اسم القسم',
                        controller: _titleController,
                        hintText: 'اسم القسم',
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
                  return AddExamSectionButtonBuilder(
                    formKey: _formKey, // Pass the form key to the button
                    titleController: _titleController,
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

/*class AddAynaaVersionAlertDialogBody extends StatefulWidget {
  const AddAynaaVersionAlertDialogBody({super.key});

  @override
  State<AddAynaaVersionAlertDialogBody> createState() =>
      _AddAynaaVersionAlertDialogBodyState();
}

class _AddAynaaVersionAlertDialogBodyState
    extends State<AddAynaaVersionAlertDialogBody> {
  final TextEditingController _aynaaVersionNameController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _aynaaVersionNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    BlocBuilder<CreateNewAynaaVersionCubit,
                        CreateNewAynaaVersionState>(
                      builder: (context, state) {
                        return CustomActionButton(
                          isLoading: state is CreateNewAynaaVersionLoading
                              ? true
                              : false,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              BlocProvider.of<CreateNewAynaaVersionCubit>(
                                      context)
                                  .createNewAynaaVersion(
                                      versionName:
                                          _aynaaVersionNameController.text);
                            } else {
                              setState(() {
                                autovalidateMode = AutovalidateMode.always;
                              });
                            }
                          },
                          icon: const FaIcon(FontAwesomeIcons.floppyDisk),
                          label: 'حفظ',
                        );
                      },
                    ),
                    /* ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          BlocProvider.of<CreateNewAynaaVersionCubit>(context)
                              .createNewAynaaVersion(
                                  versionName:
                                      _aynaaVersionNameController.text);
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),*/
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DualActionTextField(
                  controller: _aynaaVersionNameController,
                  hintText: 'إسسم النسخة',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
