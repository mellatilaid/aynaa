import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamsRepo {
  Future<Either<Failures, String>> saveExam({required ExamEntity exam});

  Future<Either<Failures, List<ExamEntity>>> fetchExams(
      {required String versionID});
  Future<Either<Failures, String>> addExam(
      {required ExamEntity exam, String? filePath});
  Future<Either<Failures, void>> deleteExam({required ExamEntity exam});
  Future<Either<Failures, String>> updateExam(
      {required ExamEntity exam, String? filePath});
}
