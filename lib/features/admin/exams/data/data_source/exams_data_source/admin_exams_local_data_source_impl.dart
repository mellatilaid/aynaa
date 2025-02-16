import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

class AdminExamsLocalDataSourceImpl extends ExamsLocalDataSource {
  @override
  Future<List<ExamEntity>> fetchExams() {
    // TODO: implement fetchExams
    throw UnimplementedError();
  }

  @override
  Future<void> handleUpdate(
      {AynaaVersionsEntity? exam,
      String? id,
      required PostgressEventType eventType}) {
    // TODO: implement handleUpdate
    throw UnimplementedError();
  }

  @override
  // TODO: implement versionsStream
  Stream<List<ExamEntity>> get versionsStream => throw UnimplementedError();
}
