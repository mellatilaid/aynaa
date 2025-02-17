import 'dart:developer';

import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/presentation/manager/add_questions_cubit/add_questions_cubit.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog_body.dart';
import 'package:atm_app/core/shared_features/exams/presentation/views/widgets/add_question_dialog_bottom_nar_bar.dart';
import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddQuestionsDialog extends StatefulWidget {
  final ExamSectionsEntity examSectionsEntity;
  const AddQuestionsDialog({
    super.key,
    required this.examSectionsEntity,
  });

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
    final List<QuestionEntity> questions =
        Provider.of<AddQuestionsCubit>(context, listen: false).questions;
    log('questions length is ${questions.length}');
    if (_questionController.text.isEmpty ||
        _answerController.text.isEmpty ||
        _optionsController.text.isEmpty) {
      showScaffoldMessage(
        context,
        'يجب ادخال السؤال والاجابة والخيارات',
        behavior: SnackBarBehavior.floating,
      );
    } else {
      Provider.of<AddQuestionsCubit>(context, listen: false)
          .setQuestion(_toQuestionEntity());
      _clearControllers();
    }
  }

  _onSave() {
    final List<QuestionEntity> questions =
        Provider.of<AddQuestionsCubit>(context, listen: false).questions;

    if (questions.isEmpty) {
      showScaffoldMessage(
        context,
        'لم تضف اي سؤال',
        behavior: SnackBarBehavior.floating,
      );
    } else {
      Provider.of<AddQuestionsCubit>(context, listen: false).addExamSection();
    }
  }

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

  _toQuestionEntity() {
    final List<String> options = _optionsController.text.split(',');
    return QuestionEntity(
      entityID: '0',
      sectionID: widget.examSectionsEntity.entityID,
      question: _questionController.text,
      answer: _answerController.text,
      options: options,
    );
  }

  _clearControllers() {
    _questionController.clear();
    _answerController.clear();
    _optionsController.clear();
  }
}
