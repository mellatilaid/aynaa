import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/models/exam_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminExamRepoImpl extends ExamsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final ExamsLocalDataSource examsLocalDataSource;
  final ExamsRemoteDataSource examsRemoteDataSource;
  final IDBSyncService idbSyncService;
  final INetworkStateService iNetworkStateService;
  AdminExamRepoImpl({
    required this.dataBase,
    required this.storageService,
    required this.examsLocalDataSource,
    required this.examsRemoteDataSource,
    required this.idbSyncService,
    required this.iNetworkStateService,
  });
  @override
  Future<Either<Failures, String>> addExam(
      {required ExamEntity exam, String? filePath}) async {
    Map<String, dynamic> data = {};
    try {
      final model = ExamModel.fromExamEntity(exam);
      data = model.toMap();
      if (filePath != null) {
        final fileName = path.basename(filePath);
        final fullPath = await storageService.uploadFile(
          bucketName: exam.versionName,
          filePath: filePath,
          fileName: '${exam.title}/$fileName',
        );
        data[kUrl] = fullPath;
      }

      await dataBase.setDate(path: DbEnpoints.exams, data: data);

      return Right(exam.versionID);
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      log(e.toString());
      //delete exam folder from storage if there is a postgress exception
      final parts = path.split(data[kUrl] as String);
      await storageService.deleteFolder(
        exam.versionName,
        parts[1],
      );
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } on StorageException catch (e) {
      return Left(ServerFailure.fromStorage(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, void>> deleteExam({required ExamEntity exam}) async {
    try {
      idbSyncService.deleteInBauckground(
        [exam],
        Entities.exam,
      );
      await dataBase.updateData(
        path: DbEnpoints.exams,
        uid: exam.entityID,
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
  Future<Either<Failures, List<ExamEntity>>> fetchExams(
      {required String versionID}) async {
    try {
      List<ExamEntity> items;
      items = await examsLocalDataSource.fetchExams(versionID: versionID);
      log(items.length.toString());
      if (items.isNotEmpty) {
        if (await iNetworkStateService.isOnline()) {
          unawaited(examsRemoteDataSource.syncExams(versionID: versionID));
        }
        return right(items);
      }
      items = await examsRemoteDataSource.fetchExams(versionID: versionID);
      updateLastFetchedItemsTime(itemType: Entities.exam);
      return right(items);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveExam({required ExamEntity exam}) {
    // TODO: implement saveExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> updateExam(
      {required ExamEntity exam, String? filePath}) async {
    try {
      final model = ExamModel.fromExamEntity(exam);
      final data = model.toMap();

      if (filePath != null) {
        //final fileName = path.basename(filePath);
        final fileName = exam.url!.replaceFirst('${exam.versionName}/', '');
        final fullPath = await storageService.updateFile(
          bucketName: exam.versionName,
          filePath: filePath,
          fileName: fileName,
        );

        data[kUrl] = fullPath;
      }

      await dataBase.updateData(
        path: DbEnpoints.exams,
        data: data,
        uid: exam.entityID,
      );
      return Right(exam.versionID);
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
