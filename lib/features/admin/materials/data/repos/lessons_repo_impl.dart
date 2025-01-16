import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_remote_data_source.dart';
import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/services/data_base.dart';
import '../../../../../core/utils/db_enpoints.dart';
import '../../domain/repos/lessons_repo.dart';

class LessonsRepoImpl extends LessonsRepo {
  final DataBase dataBase;
  final LessonsRemoteDataSource lessonsRemoteDataSource;
  LessonsRepoImpl(
      {required this.dataBase, required this.lessonsRemoteDataSource});
  @override
  Future<Either<Failures, void>> addLesson(
      {required LessonEntity lesson}) async {
    try {
      final LessonModel lessonModel = LessonModel.fromLessonEntity(lesson);

      final data = lessonModel.toMap();
      await dataBase.setDate(path: DbEnpoints.lessons, data: data);
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
  Future<Either<Failures, void>> deleteLesson({required String lessonID}) {
    // TODO: implement deleteLesson
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<LessonEntity>>> fetchLessons(
      {required String subjectID}) async {
    try {
      final List<LessonEntity> lesson =
          await lessonsRemoteDataSource.fetchLessons(subjectID: subjectID);
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
