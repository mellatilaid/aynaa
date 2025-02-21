import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/core/materials/data/models/subjects_model.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/core/services/storage_sync_service/storage_sync_service.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/helper/enums.dart';
import '../../../../../core/services/data_base.dart';
import '../../../../../core/services/storage_service.dart';
import '../../../../../core/utils/db_enpoints.dart';

class AdminSubjectsRepoImpl extends SubjectsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final SubjectsRemoteDataSource subjectsRemoteDataSource;
  final SubjectsLocalDataSource subjectsLocalDataSource;
  final StorageSyncService backgroundDownloadService;
  AdminSubjectsRepoImpl({
    required this.dataBase,
    required this.storageService,
    required this.subjectsRemoteDataSource,
    required this.subjectsLocalDataSource,
    required this.backgroundDownloadService,
  });
  @override
  Future<Either<Failures, void>> addSubject(
      {required SubjectsEntity subject, String? filePath}) async {
    try {
      final SubjectsModel subjectsModel =
          SubjectsModel.fromSubjectEntity(subject);
      final data = subjectsModel.toMap();
      log(data[kVersionName]);
      if (filePath != null) {
        final fileName = path.basename(filePath);
        final fullPath = await storageService.uploadFile(
          bucketName: subject.versionName,
          filePath: filePath,
          fileName: '${subject.subjectName}/$fileName',
        );
        data[kUrl] = fullPath;
      }
      await dataBase.setDate(path: DbEnpoints.subjects, data: data);
      return const Right(null);
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteSubject(
      {required SubjectsEntity subject}) async {
    try {
      backgroundDownloadService.deleteItemFile(
        item: subject,
        deletedItemType: DeletedItemType.subject,
      );
      await dataBase.deleteData(
        path: DbEnpoints.subjects,
        uid: subject.entityID,
      );

      return const Right(null);
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<SubjectsEntity>>> fetchSubjects(
      {required String versionID}) async {
    try {
      List<SubjectsEntity> subjects;
      subjects =
          await subjectsLocalDataSource.fetchSubjects(versionID: versionID);
      log(subjects.length.toString());
      if (subjects.isNotEmpty) return right(subjects);
      subjects =
          await subjectsRemoteDataSource.fetchSubjects(versionID: versionID);
      log(subjects.length.toString());
      return right(subjects);
    } catch (e) {
      log(e.toString());
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
