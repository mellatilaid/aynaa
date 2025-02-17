import 'package:atm_app/core/widgets/dual_text_field.dart';
import 'package:flutter/material.dart';

class AddQuestionDialogBody extends StatelessWidget {
  final TextEditingController questionController;
  final TextEditingController answerController;
  final TextEditingController optionsController;
  const AddQuestionDialogBody(
      {super.key,
      required this.questionController,
      required this.answerController,
      required this.optionsController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          DualActionTextField(
            controller: questionController,
            label: const Text('السؤال'),
          ),
          const SizedBox(
            height: 32,
          ),
          DualActionTextField(
            controller: answerController,
            label: const Text('الاجابة'),
          ),
          const SizedBox(
            height: 45,
          ),
          DualActionTextField(
            controller: optionsController,
            label: const Text('الخيارات'),
            hintText: 'الخيار الخاطئ, الخيار الصحيح, الخيار الخاطئ...',
            manLines: 3,
          ),
        ],
      ),
    );
  }
}
