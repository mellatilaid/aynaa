import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog_body.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog_bottom_nar_bar.dart';
import 'package:flutter/material.dart';

class AddQuestionsDialog extends StatefulWidget {
  const AddQuestionsDialog({super.key});

  @override
  State<AddQuestionsDialog> createState() => _AddQuestionsDialogState();
}

class _AddQuestionsDialogState extends State<AddQuestionsDialog> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _optionsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _questionController.dispose();
    _answerController.dispose();
    _optionsController.dispose();
  }

  _onAddQuestion() {
    _questionController.clear();
    _answerController.clear();
    _optionsController.clear();
  }

  _onSave() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: AddQuestionDialogBody(
        questionController: _questionController,
        answerController: _answerController,
        optionsController: _optionsController,
      ),
      bottomNavigationBar: AddQuestionDialogBottomNavBar(
        onAddQuestion: _onAddQuestion,
        onSave: _onSave,
      ),
    );
  }
}
