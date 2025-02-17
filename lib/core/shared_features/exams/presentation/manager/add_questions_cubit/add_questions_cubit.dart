import 'dart:developer';

import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_questions_state.dart';

class AddQuestionsCubit extends Cubit<AddQuestionsState> {
  final QuestionRepo questionRepo;
  AddQuestionsCubit({required this.questionRepo})
      : super(AddQuestionsInitial());

  List<QuestionEntity> _questions = [];
  Future<void> addExamSection() async {
    emit(AddQuestionsLoading());
    log(_questions.length.toString());
    final resault = await questionRepo.addQuestion(
      questions: _questions,
    );

    resault.fold((failure) {
      emit(AddQuestionsFailure(errMessage: failure.errMessage));
    }, (questionsID) {
      emit(AddQuestionsSuccuss(questionID: questionsID));
      _questions = [];
    });
  }

  void setQuestion(QuestionEntity question) {
    _questions.add(question);
    log('question length is ${_questions.length}');
  }

  get questions => _questions;
}
