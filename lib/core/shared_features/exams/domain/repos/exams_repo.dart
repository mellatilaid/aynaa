import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamsRepo {
  Future<Either<Failures, String>> saveExam({required ExamEntity exam});

  Future<Either<Failures, List<ExamEntity>>> fetchExams();
  Future<Either<Failures, void>> addExam(
      {required ExamEntity exam, String? filePath});
  Future<Either<Failures, void>> deleteExam({required ExamEntity exam});
  Future<Either<Failures, void>> updateExam(
      {required String examID, required Map<String, dynamic> data});
}
