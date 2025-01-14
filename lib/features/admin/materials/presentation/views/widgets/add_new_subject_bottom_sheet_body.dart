import 'package:atm_app/features/admin/materials/presentation/views/widgets/add_new_subject_button_bloc_builder.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/widgets/invisibla_text_field.dart';

class AddImageNoteBottomSheetBody extends StatefulWidget {
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
}
