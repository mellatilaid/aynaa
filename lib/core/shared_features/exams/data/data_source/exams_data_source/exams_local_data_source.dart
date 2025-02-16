import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

abstract class ExamsLocalDataSource {
  Future<List<ExamEntity>> fetchExams();
  Future<void> handleUpdate(
      {AynaaVersionsEntity? exam,
      String? id,
      required PostgressEventType eventType});
  Stream<List<ExamEntity>> get versionsStream;
}
