import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_questions_state.dart';

class AddQuestionsCubit extends Cubit<AddQuestionsState> {
  final QuestionRepo questionRepo;
  AddQuestionsCubit({required this.questionRepo})
      : super(AddQuestionsInitial());

  List<QuestionEntity> questions = [];
  Future<void> addExamSection() async {
    emit(AddQuestionsLoading());

    final resault = await questionRepo.addQuestion(
      questions: questions,
    );

    resault.fold((failure) {
      emit(AddQuestionsFailure(errMessage: failure.errMessage));
    }, (questionsID) {
      emit(AddQuestionsSuccuss(questionID: questionsID));
    });
  }
}
