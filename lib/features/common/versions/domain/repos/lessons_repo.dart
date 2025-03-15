import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';

abstract class LessonsRepo {
  Future<Either<Failures, String>> saveLesson({required LessonEntity lesson});

  Future<Either<Failures, List<LessonEntity>>> fetchLessons(
      {required String subjectID, required String versionID});
  Future<Either<Failures, void>> addTextLesson({
    required LessonEntity lesson,
    String? filePath,
  });

  Stream<Either<Failures, double>> addFileLesson({
    required LessonEntity lesson,
    required XFile file,
    required String uri,
  });
  Future<Either<Failures, void>> deleteLesson({required LessonEntity lesson});

  Future<Either<Failures, void>> updateLesson(
      {required LessonEntity lesson, String? filePath});
}
