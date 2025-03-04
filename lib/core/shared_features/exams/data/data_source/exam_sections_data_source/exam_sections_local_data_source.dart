import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';

abstract class ExamSectionsLocalDataSource {
  Future<List<ExamSectionsEntity>> fetchExamSections({required String examID});
  Future<void> updateCachedSection({required ExamSectionsEntity section});

  Future<void> handleUpdate(
      {ExamSectionsEntity? item,
      String? id,
      required PostgressEventType eventType});
}
