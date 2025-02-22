import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';

class AdminQuestionsRemoteDataSourceImpl extends QuestionsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;

  AdminQuestionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
  });

  @override
  Future<List<QuestionEntity>> fetchQuestions(
      {required String sectionID}) async {
    final List<Map<String, dynamic>> data = await dataBase
        .getData(path: DbEnpoints.questions, query: {kSectionID: sectionID});

    List<QuestionEntity> items = mapToListOfEntity(data, Entities.questions);
    /*isarStorageService.putAll(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<BackgroundServices<AynaaVersionsEntity>>()
        .startBackgroundDownloads(versions);*/
    log(items.length.toString());
    return items;
  }
}
