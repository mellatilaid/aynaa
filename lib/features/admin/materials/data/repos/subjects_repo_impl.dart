import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/models/subjects_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/data_base.dart';
import '../../../../../core/utils/db_enpoints.dart';

class SubjectsRepoImpl extends SubjectsRepo {
  final DataBase dataBase;
  final SubjectsRemoteDataSource subjectsRemoteDataSource;

  SubjectsRepoImpl(
      {required this.dataBase, required this.subjectsRemoteDataSource});
  @override
  Future<Either<Failures, void>> addSubject(
      {required SubjectsEntity subject}) async {
    try {
      final SubjectsModel subjectsModel =
          SubjectsModel.fromSubjectEntity(subject);
      final data = subjectsModel.toMap();
      await dataBase.setDate(path: DbEnpoints.subjects, data: data);
      return const Right(null);
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteSubject({required String subjectID}) {
    // TODO: implement deleteSubject
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<SubjectsEntity>>> fetchSubjects(
      {required String versionID}) async {
    try {
      final List<SubjectsEntity> subjects =
          await subjectsRemoteDataSource.fetchSubjects(versionID: versionID);
      return right(subjects);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveSubject(
      {required SubjectsEntity subject}) {
    // TODO: implement saveSubject
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateSubject(
      {required String subjectID, required Map<String, dynamic> data}) {
    // TODO: implement updateSubject
    throw UnimplementedError();
  }
}
