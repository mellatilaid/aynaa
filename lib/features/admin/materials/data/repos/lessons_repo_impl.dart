import 'dart:developer';

import 'package:atm_app/const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/data_base.dart';
import '../../../../../core/utils/db_enpoints.dart';
import '../../domain/repos/lessons_repo.dart';

class LessonsRepoImpl extends LessonsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final LessonsRemoteDataSource lessonsRemoteDataSource;
  LessonsRepoImpl({
    required this.dataBase,
    required this.lessonsRemoteDataSource,
    required this.storageService,
  });
  @override
  Future<Either<Failures, void>> addLesson({
    required LessonEntity lesson,
    String? filePath,
  }) async {
    try {
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);

      final data = lessonModel.toMap();
      if (filePath != null) {
        final fileName = path.basename(filePath);
        final String fullPath = await storageService.uploadFile(
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
  Future<Either<Failures, void>> deleteLesson({required String lessonID}) {
    // TODO: implement deleteLesson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<LessonEntity>>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    try {
      final List<LessonEntity> lesson = await lessonsRemoteDataSource
          .fetchLessons(subjectID: subjectID, versionID: versionID);
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
      {required String lessonID, required Map<String, dynamic> data}) {
    // TODO: implement updateLesson
    throw UnimplementedError();
  }
}
