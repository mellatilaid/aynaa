import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/models/question_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class QuestionRepoImpl extends QuestionRepo {
  final DataBase dataBase;
  final StorageService storageService;

  QuestionRepoImpl({required this.dataBase, required this.storageService});
  @override
  Future<Either<Failures, String>> addQuestion(
      {required QuestionEntity question}) async {
    try {
      final model = QuestionModel.fromEntity(question);
      final data = model.toMap();

      await dataBase.setDate(path: DbEnpoints.questions, data: data);

      return Right(question.entityID.toString());
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
  Future<Either<Failures, void>> deleteQuestion(
      {required QuestionEntity question}) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, List<ExamEntity>>> fetchQuestions() {
    // TODO: implement fetchQuestions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> saveExam(
      {required QuestionEntity question}) {
    // TODO: implement saveExam
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, void>> updateExam(
      {required String questionID, required Map<String, dynamic> data}) {
    // TODO: implement updateExam
    throw UnimplementedError();
  }
}
