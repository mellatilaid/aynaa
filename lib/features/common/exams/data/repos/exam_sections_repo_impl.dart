import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/helper/name_encrypte.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/remote_db_service/i_remote_d_b_service.dart';
import 'package:atm_app/core/services/remote_storage_service/i_remote_storage_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/common/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';
import 'package:atm_app/features/common/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/features/common/exams/domain/repos/exam_sections_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../common/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';

class ExamSectionsRepoImpl extends ExamSectionsRepo {
  final IRemoteDBService dataBase;
  final IRemoteStorageService storageService;
  final ExamSectionsLocalDataSource localDataSource;
  final ExamSectionsRemoteDataSource remoteDataSource;
  final IDBSyncService idbSyncService;
  final INetworkStateService iNetworkStateService;
  ExamSectionsRepoImpl({
    required this.dataBase,
    required this.storageService,
    required this.iNetworkStateService,
    required this.idbSyncService,
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failures, String>> addExamSection(
      {required ExamSectionsEntity examSection, String? filePath}) async {
    try {
      final model = ExamSectionsModel.fromEntity(examSection);
      final data = model.toMap();
      if (filePath != null) {
        final fileName = path.basename(filePath);
        final fullPath = await storageService.uploadFile(
          bucketName: encrypteName(examSection.versionName),
          filePath: filePath,
          fileName: '${encrypteName(examSection.examTitle)}/$fileName',
        );
        data[kUrl] = fullPath;
      }

      await dataBase.setDate(path: DbEnpoints.examSections, data: data);

      return Right(examSection.examID.toString());
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } on StorageException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromStorage(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteExamSection(
      {required ExamSectionsEntity examSection}) async {
    try {
      idbSyncService.deleteInBauckground([examSection], Entities.examSections);
      await dataBase.updateData(
        path: DbEnpoints.examSections,
        uid: examSection.entityID,
        data: {
          kIsDeleted: true,
        },
      );
      return right(null);
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } on StorageException catch (e) {
      return Left(ServerFailure.fromStorage(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<ExamSectionsEntity>>> fetchExamSections(
      {required String examID}) async {
    try {
      List<ExamSectionsEntity> items;
      items = await localDataSource.fetchExamSections(examID: examID);

      if (items.isNotEmpty) {
        if (await iNetworkStateService.isOnline()) {
          unawaited(remoteDataSource.syncSections(examID: examID));
        }
        return right(items);
      }
      items = await remoteDataSource.fetchExamSections(examID: examID);

      return right(items);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveExam({required ExamEntity examSection}) {
    // TODO: implement saveExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> updateExamSection(
      {required ExamSectionsEntity section, String? filePath}) async {
    try {
      final lessonModel = ExamSectionsModel.fromEntity(section);
      final data = lessonModel.toMap();

      if (filePath != null) {
        //final fileName = path.basename(filePath);
        final encryptedName = encrypteName(section.versionName);
        final fileName = section.url!.replaceFirst('$encryptedName/', '');
        final fullPath = await storageService.updateFile(
          bucketName: encryptedName,
          filePath: filePath,
          fileName: fileName,
        );
        // data[kPickedFilePath] = filePath;

        data[kUrl] = fullPath;
      }
      // data[kOldUrl] = lesson.url;
      await dataBase.updateData(
        path: DbEnpoints.examSections,
        data: data,
        uid: section.entityID,
      );
      return Right(section.examID);
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
