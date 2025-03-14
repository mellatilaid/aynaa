import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/helper/name_encrypte.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/features/common/versions/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/models/lesson_model.dart';
import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/lessons_repo.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tus_client_dart/tus_client_dart.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../data_source/lessons_data_source/lessons_remote_data_source.dart';

class LessonsRepoImpl extends LessonsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final IDBSyncService idbSyncService;
  final LessonsRemoteDataSource lessonsRemoteDataSource;
  final LessonsLocalDataSource lessonsLocalDataSource;
  final INetworkStateService iNetworkStateService;
  LessonsRepoImpl({
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
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternetMessage));
      }
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);

      final data = lessonModel.toMap();
      final encryptedVersionName = encrypteName(lesson.versionName);
      final encryptedSubjectName = encrypteName(lesson.subjectName);
      if (filePath != null) {
        final fileName = path.basename(filePath);

        final fullPath = await storageService.uploadFile(
          bucketName: encryptedVersionName,
          filePath: filePath,
          fileName: '$encryptedSubjectName/$fileName',
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
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternetMessage));
      }
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
        }
        return right(lesson);
      }
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternetMessage));
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
      if (!await iNetworkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternetMessage));
      }
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);
      final data = lessonModel.toMap();

      if (filePath != null) {
        //final fileName = path.basename(filePath);
        final encryptedVersionName = encrypteName(lesson.versionName);
        final fileName = lesson.url!.replaceFirst('$encryptedVersionName/', '');
        final fullPath = await storageService.updateFile(
          bucketName: encryptedVersionName,
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
