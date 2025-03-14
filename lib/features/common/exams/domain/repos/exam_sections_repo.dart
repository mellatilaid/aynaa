import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ExamSectionsRepo {
  Future<Either<Failures, String>> saveExam({required ExamEntity examSection});

  Future<Either<Failures, List<ExamSectionsEntity>>> fetchExamSections(
      {required String examID});
  Future<Either<Failures, String>> addExamSection(
      {required ExamSectionsEntity examSection, String? filePath});
  Future<Either<Failures, void>> deleteExamSection(
      {required ExamSectionsEntity examSection});
  Future<Either<Failures, String>> updateExamSection(
      {required ExamSectionsEntity section, String? filePath});
}
