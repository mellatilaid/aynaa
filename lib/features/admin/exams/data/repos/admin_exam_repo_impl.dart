import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/data_base.dart';
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
  AdminExamRepoImpl({
    required this.dataBase,
    required this.storageService,
    required this.examsLocalDataSource,
    required this.examsRemoteDataSource,
  });
  @override
  Future<Either<Failures, void>> addExam(
      {required ExamEntity exam, String? filePath}) async {
    try {
      final model = ExamModel.fromExamEntity(exam);
      final data = model.toMap();
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

      return const Right('');
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
  Future<Either<Failures, void>> deleteExam({required ExamEntity exam}) {
    // TODO: implement deleteExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<ExamEntity>>> fetchExams() async {
    try {
      final List<ExamEntity> localVersions =
          await examsLocalDataSource.fetchExams();
      log(localVersions.length.toString());
      if (localVersions.isNotEmpty) {
        return right(localVersions);
      }
      final List<ExamEntity> remoteVersions =
          await examsRemoteDataSource.fetchAynaaVersions();
      log('remote version ${remoteVersions.length}');
      return right(remoteVersions);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveExam({required ExamEntity exam}) {
    // TODO: implement saveExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateExam(
      {required String examID, required Map<String, dynamic> data}) {
    // TODO: implement updateExam
    throw UnimplementedError();
  }
}
