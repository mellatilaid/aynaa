import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';

abstract class ExamSectionsLocalDataSource {
  Future<List<ExamEntity>> fetchExamSections({required String examID});
  Future<void> handleUpdate(
      {ExamSectionsEntity? item,
      String? id,
      required PostgressEventType eventType});
}
