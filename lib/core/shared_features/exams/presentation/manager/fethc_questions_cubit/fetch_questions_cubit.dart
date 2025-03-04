import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionsState> {
  FetchQuestionsCubit(
      {required this.questionsRepo, required this.iLocalDbService})
      : super(FetchQuestionsInitial());
  final QuestionRepo questionsRepo;
  final ILocalDbService iLocalDbService;

  @override
  bool isClosed = false;

  Future<void> fetchQuestions({required String id}) async {
    emit(FetchQuestionsLoading());
    final result = await questionsRepo.fetchQuestions(sectionID: id);
    result.fold(
        (failure) =>
            emit(FetchQuestionsFailure(errMessage: failure.errMessage)),
        (sections) {
      emit(FetchQuestionsSuccuss(questions: sections));
      _stream(id: id);
    });
  }

  void _stream({
    required String id,
  }) {
    iLocalDbService
        .watchAll<QuestionEntity>(collectionType: Entities.questions, id: id)
        .listen((items) {
      if (isClosed) return;

      emit(
        FetchQuestionsSuccuss(questions: items),
      );
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close

    isClosed = true;
    return super.close();
  }
}
