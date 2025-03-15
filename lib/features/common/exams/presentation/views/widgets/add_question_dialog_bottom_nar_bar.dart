import 'package:atm_app/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

import 'save_questions_button_builder.dart';

class AddQuestionDialogBottomNavBar extends StatelessWidget {
  final VoidCallback onAddQuestion;
  final VoidCallback onSave;
  final VoidCallback onEditQuestion;
  final bool isEditMode;
  const AddQuestionDialogBottomNavBar({
    super.key,
    required this.isEditMode,
    required this.onAddQuestion,
    required this.onSave,
    required this.onEditQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 32),
      child: (isEditMode)
          ? SaveQuestionsButtonBuilder(
              isEditMode: isEditMode,
              onSave: onEditQuestion,
            )
          : Row(children: [
              Expanded(
                child: CustomTextButton(
                  title: isEditMode ? 'تحديث السؤال' : 'إضافة السؤال',
                  onPressed: onAddQuestion,
                ),
              ),
              Expanded(
                child: SaveQuestionsButtonBuilder(
                  isEditMode: isEditMode,
                  onSave: onSave,
                ),
              ),
            ]),
    );
  }
}
