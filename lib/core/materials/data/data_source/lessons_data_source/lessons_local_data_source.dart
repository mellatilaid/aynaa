import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID});
  Future<void> handleUpdate(
      {required PostgressEventType eventType, LessonEntity? lesson, String id});
  Stream<List<LessonEntity>> get lessonsStream;
}
