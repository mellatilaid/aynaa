import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/features/common/versions/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/features/common/versions/data/models/subjects_model.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/subjects_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/services/storage_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';

class SubjectsRepoImpl extends SubjectsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final SubjectsRemoteDataSource subjectsRemoteDataSource;
  final SubjectsLocalDataSource subjectsLocalDataSource;
  final IDBSyncService iDBSyncService;
  final INetworkStateService iNetworkStateService;
  SubjectsRepoImpl({
    required this.dataBase,
    required this.storageService,
    required this.subjectsRemoteDataSource,
    required this.subjectsLocalDataSource,
    required this.iDBSyncService,
    required this.iNetworkStateService,
  });
  @override
  Future<Either<Failures, String>> addSubject(
      {required SubjectsEntity subject, String? filePath}) async {
    try {
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternetMessage));
      }
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
      return Right(subject.versionID);
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
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
      iDBSyncService.deleteInBauckground(
        [subject],
        Entities.subjects,
      );
      await dataBase.updateData(
        path: DbEnpoints.subjects,
        uid: subject.entityID,
        data: {
          kIsDeleted: true,
        },
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

      if (subjects.isNotEmpty) {
        if (await iNetworkStateService.isOnline()) {
          unawaited(subjectsRemoteDataSource.syncDB(versionID: versionID));
        }
        return right(subjects);
      }
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
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

  ///
  /// Updates a subject in the database
  ///
  /// This function takes a [SubjectsEntity] and an optional file path as parameters.
  /// It will update the subject with the new file path if it is different from the
  /// existing file path.
  ///
  /// If the file path is null, or if the file path is the same as the existing file
  /// path, the function will not update the subject.
  ///
  /// If the file path is different from the existing file path, the function will
  /// upload the file to the storage service and update the subject with the new file
  /// path.

  /// If the function fails, it will return a [Left] with a [Failures] object that
  /// contains the error message.
  ///
  /// If the function succeeds, it will return a [Right] with the version ID of the
  /// subject.
  Future<Either<Failures, String>> updateSubject(
      {required SubjectsEntity subject, String? filePath}) async {
    try {
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
      final SubjectsModel subjectsModel =
          SubjectsModel.fromSubjectEntity(subject);
      final data = subjectsModel.toMap();
      log(data[kVersionName]);
      log(subject.pickedFilePath.toString());
      log(filePath.toString());

      if (filePath != null) {
        //final fileName = path.basename(filePath);
        final fileName =
            subject.url.replaceFirst('${subject.versionName}/', '');
        final fullPath = await storageService.updateFile(
          bucketName: subject.versionName,
          filePath: filePath,
          fileName: fileName,
        );
        data[kPickedFilePath] = filePath;

        data[kUrl] = fullPath;
      }
      data[kOldUrl] = subject.url;
      await dataBase.updateData(
        path: DbEnpoints.subjects,
        data: data,
        uid: subject.entityID,
      );
      return Right(subject.versionID);
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
}
