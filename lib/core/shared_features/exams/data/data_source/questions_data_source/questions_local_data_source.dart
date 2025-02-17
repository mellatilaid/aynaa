import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';

abstract class QuestionsLocalDataSource {
  Future<List<QuestionEntity>> fetchQuestions({required String sectionID});
  Future<void> handleUpdate(
      {QuestionEntity? item,
      String? id,
      required PostgressEventType eventType});
  Stream<List<ExamEntity>> get versionsStream;
}
