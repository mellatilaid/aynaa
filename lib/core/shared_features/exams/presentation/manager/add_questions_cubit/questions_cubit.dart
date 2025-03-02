import 'dart:developer';

import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final QuestionRepo questionRepo;
  QuestionsCubit({required this.questionRepo}) : super(QuestionsInitial());

  List<QuestionEntity> _questions = [];
  Future<void> addExamSection() async {
    emit(QuestionsLoading());
    log(_questions.length.toString());
    final resault = await questionRepo.addQuestion(
      questions: _questions,
    );

    resault.fold((failure) {
      emit(QuestionsFailure(errMessage: failure.errMessage));
    }, (questionsID) {
      emit(QuestionsSuccuss(questionID: questionsID));
      _questions = [];
    });
  }

  Future<void> deleteQuestion({required QuestionEntity question}) async {
    emit(QuestionsLoading());

    final resault = await questionRepo.deleteQuestion(
      question: question,
    );

    resault.fold((failure) {
      emit(QuestionsFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(DeleteQuestionSuccuss());
      _questions = [];
    });
  }

  void setQuestion(QuestionEntity question) {
    _questions.add(question);
    log('question length is ${_questions.length}');
  }

  get questions => _questions;
}
