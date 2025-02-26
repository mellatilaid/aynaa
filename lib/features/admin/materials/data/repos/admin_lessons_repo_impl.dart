import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/materials/data/models/lesson_model.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tus_client_dart/tus_client_dart.dart';

import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import '../../../../../core/services/data_base.dart';
import '../../../../../core/utils/db_enpoints.dart';

class AdminLessonsRepoImpl extends LessonsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final IDBSyncService idbSyncService;
  final LessonsRemoteDataSource lessonsRemoteDataSource;
  final LessonsLocalDataSource lessonsLocalDataSource;
  final INetworkStateService iNetworkStateService;
  AdminLessonsRepoImpl({
    required this.dataBase,
    required this.lessonsRemoteDataSource,
    required this.storageService,
    required this.lessonsLocalDataSource,
    required this.idbSyncService,
    required this.iNetworkStateService,
  });
  @override
  Future<Either<Failures, void>> addTextLesson({
    required LessonEntity lesson,
    String? filePath,
  }) async {
    try {
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);

      final data = lessonModel.toMap();

      if (filePath != null) {
        final fileName = path.basename(filePath);
        final fullPath = await storageService.uploadFile(
          bucketName: lesson.versionName,
          filePath: filePath,
          fileName: '${lesson.subjectName}/$fileName',
        );
        data[kUrl] = fullPath;
      }

      await dataBase.setDate(path: DbEnpoints.lessons, data: data);
      return const Right(null);
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
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
  Future<Either<Failures, void>> deleteLesson(
      {required LessonEntity lesson}) async {
    try {
      idbSyncService.deleteInBauckground([lesson], Entities.lessons);
      await dataBase.updateData(
        path: DbEnpoints.lessons,
        uid: lesson.entityID,
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
  Future<Either<Failures, List<LessonEntity>>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    try {
      List<LessonEntity> lesson;
      lesson = await lessonsLocalDataSource.fetchLessons(
          versionID: versionID, subjectID: subjectID);
      if (lesson.isNotEmpty) {
        if (await iNetworkStateService.isOnline()) {
          unawaited(lessonsRemoteDataSource.syncDB(subjectID: subjectID));
          return right(lesson);
        }
      }
      lesson = await lessonsRemoteDataSource.fetchLessons(
          subjectID: subjectID, versionID: versionID);
      return right(lesson);
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveLesson({required LessonEntity lesson}) {
    // TODO: implement saveLesson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateLesson(
      {required LessonEntity lesson, String? filePath}) async {
    try {
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);
      final data = lessonModel.toMap();

      if (filePath != null) {
        //final fileName = path.basename(filePath);
        final fileName = lesson.url!.replaceFirst('${lesson.versionName}/', '');
        final fullPath = await storageService.updateFile(
          bucketName: lesson.versionName,
          filePath: filePath,
          fileName: fileName,
        );
        // data[kPickedFilePath] = filePath;

        data[kUrl] = fullPath;
      }
      // data[kOldUrl] = lesson.url;
      await dataBase.updateData(
        path: DbEnpoints.lessons,
        data: data,
        uid: lesson.entityID,
      );
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
  Stream<Either<Failures, double>> addFileLesson(
      {required LessonEntity lesson,
      required XFile file,
      required String uri}) async* {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempDirectory = Directory('${tempDir.path}/${file.name}_uploads');
      if (!tempDirectory.existsSync()) {
        tempDirectory.createSync(recursive: true);
      }
      final tusClient = TusClient(
        file,
        store: TusFileStore(tempDirectory),
        maxChunkSize: 1024 * 1024 * 6,
        retries: 10, // change as wanted
        retryInterval: 2, // interval in seconds
        retryScale: RetryScale.exponential,
      );

      await tusClient.upload(
        uri: Uri.parse(uri),
        metadata: {
          'bucketName': lesson.versionName,
          'objectName': '${lesson.subjectName}/${file.name}',
          //content type, e.g. application/octet-
          'contentType': 'application/pdf',
          'cacheControl': '3600',
        },
        onProgress: (progress, estimate) async* {
          log('progress $progress');
          yield right(progress); // Emit progress updates
        },
        onComplete: () async {
          tempDirectory.deleteSync(recursive: true);
        },
        headers: {
          'Authorization':
              'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
          // Set to true to enable overwrite
          'x-upsert': 'true'
        },
      );
    } catch (e) {
      log(e.toString());
      yield left(ServerFailure(errMessage: e.toString()));
    }
  }
}
