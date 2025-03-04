import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/db_filter_types.dart';

import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID});
  Future<void> syncDB({required String subjectID});
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final ILocalSettingsService iLocalSettingsService;
  final IDBSyncService storageSyncService;
  LessonsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
    required this.storageSyncService,
    required this.iLocalSettingsService,
  });
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    log(subjectID);
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.lessons, query: {
      kSubjectID: subjectID,
      kIsDeleted: false,
    });

    List<LessonEntity> lessons =
        mapToListOfEntity<LessonEntity>(data, Entities.lessons);

    if (lessons.isNotEmpty) {
      iLocalDbService.putAll<LessonEntity>(
        items: lessons,
        collentionType: Entities.lessons,
      );
      storageSyncService.donwloadInBauckground(lessons, Entities.lessons);
    }
    updateLastFetchedItemsTime(itemType: Entities.lessons);
    return lessons;
  }

  @override
  Future<void> syncDB({required String subjectID}) async {
    final settings = await iLocalSettingsService.getSettings();
    storageSyncService.syncDB<LessonEntity>(
      path: DbEnpoints.lessons,
      entityType: Entities.lessons,
      updtatedItemsQuery: {
        kSubjectID: subjectID,
        kUpdatedAt: {
          DbFilterTypes.greaterThan: settings!.lastTimeLessonssFetched
        }
      },
      deletedItemsQuery: {kSubjectID: subjectID, kIsDeleted: true},
      lastTimeItemsFetched: settings.lastTimeLessonssFetched!,
    );
  }
}
