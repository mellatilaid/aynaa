import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';

abstract class QuestionsRemoteDataSource {
  Future<List<QuestionEntity>> fetchQuestions({required String sectionID});
}
