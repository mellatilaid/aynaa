import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SubjectsRepo {
  Future<Either<Failures, String>> saveSubject(
      {required SubjectsEntity subject});

  Future<Either<Failures, List<SubjectsEntity>>> fetchSubjects(
      {required String versionID});
  Future<Either<Failures, void>> addSubject({required SubjectsEntity subject});
  Future<Either<Failures, void>> deleteSubject({required String subjectID});
  Future<Either<Failures, void>> updateSubject(
      {required String subjectID, required Map<String, dynamic> data});
}
