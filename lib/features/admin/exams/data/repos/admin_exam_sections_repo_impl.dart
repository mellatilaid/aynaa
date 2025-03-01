import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';

class AdminExamSectionsRepoImpl extends ExamSectionsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final ExamSectionsLocalDataSource localDataSource;
  final ExamSectionsRemoteDataSource remoteDataSource;
  final IDBSyncService idbSyncService;
  final INetworkStateService iNetworkStateService;
  AdminExamSectionsRepoImpl({
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
          bucketName: examSection.versionName,
          filePath: filePath,
          fileName: '${examSection.examTitle}/$fileName',
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
  Future<Either<Failures, void>> updateExamSection(
      {required String examID, required Map<String, dynamic> data}) {
    // TODO: implement updateExamSection
    throw UnimplementedError();
  }
}
