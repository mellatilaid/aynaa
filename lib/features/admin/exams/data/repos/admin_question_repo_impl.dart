import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/data/models/question_model.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/question_repo.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminQuestionRepoImpl extends QuestionRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final INetworkStateService iNetworkStateService;
  final QuestionsRemoteDataSource remoteDataSource;
  final QuestionsLocalDataSource localDataSource;
  final IDBSyncService idbSyncService;
  AdminQuestionRepoImpl({
    required this.dataBase,
    required this.idbSyncService,
    required this.storageService,
    required this.iNetworkStateService,
    required this.localDataSource,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failures, String>> addQuestion(
      {required List<QuestionEntity> questions}) async {
    try {
      for (var question in questions) {
        final model = QuestionModel.fromEntity(question);
        final data = model.toMap();

        await dataBase.setDate(path: DbEnpoints.questions, data: data);
      }
      return Right(questions.first.sectionID.toString());
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
      {required QuestionEntity question}) async {
    try {
      idbSyncService.deleteInBauckground(
        [question],
        Entities.questions,
      );
      await dataBase.updateData(
        path: DbEnpoints.questions,
        uid: question.entityID,
        data: {
          kIsDeleted: true,
        },
      );

      return const Right(null);
    } on PostgrestException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, List<QuestionEntity>>> fetchQuestions(
      {required String sectionID}) async {
    try {
      List<QuestionEntity> items;

      items = await localDataSource.fetchQuestions(sectionID: sectionID);

      if (items.isNotEmpty) {
        if (await iNetworkStateService.isOnline()) {
          unawaited(remoteDataSource.syncQuestions(sectionID: sectionID));
        }
        return right(items);
      }
      items = await remoteDataSource.fetchQuestions(sectionID: sectionID);

      return right(items);
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> updateQuestions(
      {required List<QuestionEntity> questions}) async {
    try {
      for (var question in questions) {
        final model = QuestionModel.fromEntity(question);
        final data = model.toMap();

        await dataBase.updateData(
          path: DbEnpoints.questions,
          data: data,
          uid: question.entityID,
        );
      }

      return Right(questions.first.sectionID.toString());
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
