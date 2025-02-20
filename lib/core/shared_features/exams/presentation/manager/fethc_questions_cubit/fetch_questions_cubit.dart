import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionsState> {
  FetchQuestionsCubit(
      {required this.questionsRepo, required this.isarStorageService})
      : super(FetchQuestionsInitial());
  final QuestionRepo questionsRepo;
  final LocalDBService isarStorageService;

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
    });
  }

  void _stream({
    required String id,
  }) {
    isarStorageService
        .watchAll<ExamSectionsEntity>(
            collectionType: CollentionType.subjects, id: id)
        .listen((items) {
      if (isClosed) return;

      /*emit(
        FetchQuestionsSuccuss(questions: items),
      );*/
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close

    isClosed = true;
    return super.close();
  }
}
