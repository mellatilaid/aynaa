import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SubjectsRepo {
  Future<Either<Failures, String>> saveSubject(
      {required SubjectsEntity subject});

  Future<Either<Failures, List<SubjectsEntity>>> fetchSubjects(
      {required String versionID});
  Future<Either<Failures, String>> addSubject(
      {required SubjectsEntity subject, String? filePath});
  Future<Either<Failures, void>> deleteSubject(
      {required SubjectsEntity subject});
  Future<Either<Failures, String>> updateSubject(
      {required SubjectsEntity subject, String? filePath});
}
