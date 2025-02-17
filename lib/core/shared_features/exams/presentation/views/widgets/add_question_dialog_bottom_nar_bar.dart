import 'package:atm_app/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class AddQuestionDialogBottomNavBar extends StatelessWidget {
  final VoidCallback onAddQuestion;
  final VoidCallback onSave;
  const AddQuestionDialogBottomNavBar({
    super.key,
    required this.onAddQuestion,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32),
      child: Row(children: [
        Expanded(
          child: CustomTextButton(
            title: 'إضافة سؤال',
            onPressed: onAddQuestion,
          ),
        ),
        Expanded(
          child: CustomTextButton(
            title: 'حفظ',
            onPressed: onSave,
          ),
        ),
      ]),
    );
  }
}
