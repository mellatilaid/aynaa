import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionRepo {
  Future<Either<Failures, List<QuestionEntity>>> fetchQuestions(
      {required String sectionID});
  Future<Either<Failures, String>> addQuestion(
      {required List<QuestionEntity> questions});
  Future<Either<Failures, void>> deleteQuestion(
      {required QuestionEntity question});
  Future<Either<Failures, String>> updateQuestions(
      {required List<QuestionEntity> questions});
}
