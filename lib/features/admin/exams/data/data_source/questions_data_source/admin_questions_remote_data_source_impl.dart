import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/db_filter_types.dart';

class AdminQuestionsRemoteDataSourceImpl extends QuestionsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final IDBSyncService idbSyncService;
  final ILocalSettingsService iLocalSettingsService;
  AdminQuestionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.idbSyncService,
    required this.iLocalDbService,
    required this.iLocalSettingsService,
  });

  @override
  Future<List<QuestionEntity>> fetchQuestions(
      {required String sectionID}) async {
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.questions, query: {
      kSectionID: sectionID,
      kIsDeleted: false,
    });

    List<QuestionEntity> items = mapToListOfEntity(data, Entities.questions);
    iLocalDbService.putAll<QuestionEntity>(items: items);
    updateLastFetchedItemsTime(itemType: Entities.questions);
    return items;
  }

  @override
  Future<void> syncQuestions({required String sectionID}) async {
    final settings = await iLocalSettingsService.getSettings();
    idbSyncService.syncDB<QuestionEntity>(
      path: DbEnpoints.questions,
      entityType: Entities.questions,
      updtatedItemsQuery: {
        kSectionID: sectionID,
        kUpdatedAt: {
          DbFilterTypes.greaterThan: settings!.lastTimeQuestionsFetched
        }
      },
      deletedItemsQuery: {kSectionID: sectionID, kIsDeleted: true},
      lastTimeItemsFetched: settings.lastTimeQuestionsFetched!,
    );
  }
}
