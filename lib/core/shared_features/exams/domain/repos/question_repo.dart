import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionRepo {
  Future<Either<Failures, String>> saveExam({required QuestionEntity question});

  Future<Either<Failures, List<ExamEntity>>> fetchQuestions();
  Future<Either<Failures, void>> addQuestion(
      {required QuestionEntity question});
  Future<Either<Failures, void>> deleteQuestion(
      {required QuestionEntity question});
  Future<Either<Failures, void>> updateExam(
      {required String questionID, required Map<String, dynamic> data});
}
