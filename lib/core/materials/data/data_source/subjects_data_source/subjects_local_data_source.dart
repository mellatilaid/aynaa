import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';

abstract class SubjectsLocalDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> deleteSubject({required String subjectID});
  Future<void> handleUpdate(
      {SubjectsEntity? subject,
      String? id,
      required PostgressEventType eventType});
  Stream<List<SubjectsEntity>> get subjectsStream;
}
