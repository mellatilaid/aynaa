import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

abstract class ExamsLocalDataSource {
  Future<List<ExamEntity>> fetchExams({required String versionID});
  Future<void> handleUpdate(
      {ExamEntity? exam, String? id, required PostgressEventType eventType});
  Stream<List<ExamEntity>> get versionsStream;
}
