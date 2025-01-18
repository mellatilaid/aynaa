import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LessonsRepo {
  Future<Either<Failures, String>> saveLesson({required LessonEntity lesson});

  Future<Either<Failures, List<LessonEntity>>> fetchLessons(
      {required String subjectID, required String versionID});
  Future<Either<Failures, void>> addLesson({required LessonEntity lesson});

  Future<Either<Failures, void>> deleteLesson({required String lessonID});

  Future<Either<Failures, void>> updateLesson(
      {required String lessonID, required Map<String, dynamic> data});
}
