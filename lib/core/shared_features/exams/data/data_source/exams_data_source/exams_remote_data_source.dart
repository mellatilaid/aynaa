import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

abstract class ExamsRemoteDataSource {
  Future<List<ExamEntity>> fetchExams({required String versionID});
  Future<void> syncExams({required String versionID});
}
