import 'dart:developer';

import 'package:atm_app/core/widgets/scaffold_message.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';
import 'package:atm_app/features/common/exams/presentation/manager/add_questions_cubit/questions_cubit.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/add_question_dialog_body.dart';
import 'package:atm_app/features/common/exams/presentation/views/widgets/add_question_dialog_bottom_nar_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddQuestionsDialog extends StatefulWidget {
  final ExamSectionsEntity? examSectionsEntity;
  final bool isEditMode;
  final QuestionEntity? questionEntity;

  const AddQuestionsDialog({
    super.key,
    this.examSectionsEntity,
    this.isEditMode = false,
    this.questionEntity,
  });

  factory AddQuestionsDialog.edit({required QuestionEntity questionEntity}) {
    return AddQuestionsDialog(
      isEditMode: true,
      questionEntity: questionEntity,
    );
  }

  @override
  State<AddQuestionsDialog> createState() => _AddQuestionsDialogState();
}

class _AddQuestionsDialogState extends State<AddQuestionsDialog> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _optionsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditMode) {
      _questionController.text = widget.questionEntity!.question;
      _answerController.text = widget.questionEntity!.answer;
      _optionsController.text = widget.questionEntity!.options.join(',');
    }
  }

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
        Provider.of<QuestionsCubit>(context, listen: false).questions;

    //if is edit mode and the question is not changed do not add it

    if (_questionController.text.isEmpty ||
        _answerController.text.isEmpty ||
        _optionsController.text.isEmpty) {
      showScaffoldMessage(
        context,
        'يجب ادخال السؤال والاجابة والخيارات',
        behavior: SnackBarBehavior.floating,
      );
    } else {
      Provider.of<QuestionsCubit>(context, listen: false)
          .setQuestion(_toQuestionEntity());
      //if is edit mode do not clear the controllers
      if (widget.isEditMode) {
        return;
      }
      _clearControllers();
    }
  }

  _onSave() {
    final List<QuestionEntity> questions =
        Provider.of<QuestionsCubit>(context, listen: false).questions;

    if (questions.isEmpty) {
      showScaffoldMessage(
        context,
        widget.isEditMode ? 'لم يتم تعديل اي سؤال' : 'لم تضف اي سؤال',
        behavior: SnackBarBehavior.floating,
      );
    } else {
      Provider.of<QuestionsCubit>(context, listen: false).addQuestions();
    }
  }

  _onEdit() {
    if (widget.isEditMode &&
        _questionController.text.trim() == widget.questionEntity?.question &&
        _answerController.text.trim() == widget.questionEntity?.answer &&
        _optionsController.text.trim() ==
            widget.questionEntity?.options.join(',')) {
      showScaffoldMessage(
        context,
        'يجب  تعديل السؤال أو الاجابة أو الخيارات',
        behavior: SnackBarBehavior.floating,
      );
    } else {
      //add the updated question to the questions list in the cubit
      //update the questions
      Provider.of<QuestionsCubit>(context, listen: false)
          .setQuestion(_toQuestionEntity());
      Provider.of<QuestionsCubit>(context, listen: false).updateQuestions();
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
        isEditMode: widget.isEditMode,
        onAddQuestion: _onAddQuestion,
        onSave: _onSave,
        onEditQuestion: _onEdit,
      ),
    );
  }

  _toQuestionEntity() {
    final List<String> options = _optionsController.text
        .split(RegExp(r'[،,]'))
        .map((e) => e.trim())
        .toList();
    for (var i = 0; i < options.length; i++) {
      log(options[i]);
    }
    if (widget.isEditMode) {
      return widget.questionEntity!.copyWith(
        question: _questionController.text,
        answer: _answerController.text,
        options: options,
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
    }
    return QuestionEntity(
      entityID: '0',
      sectionID: widget.examSectionsEntity!.entityID,
      question: _questionController.text,
      answer: _answerController.text,
      options: options,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    );
  }

  _clearControllers() {
    _questionController.clear();
    _answerController.clear();
    _optionsController.clear();
  }
}
