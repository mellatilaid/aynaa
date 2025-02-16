import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';

abstract class ExamSectionsRemoteDataSource {
  Future<List<ExamSectionsEntity>> fetchExamSections({required String examID});
}
