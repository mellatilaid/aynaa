import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/utils/db_filter_types.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';

import '../../../../../../../core/const/remote_db_const.dart';
import '../../../../../../../core/helper/enums.dart';
import '../../../../../../../core/utils/db_enpoints.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> syncDB({required String versionID});
}

class SubjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final IDBSyncService storageSyncService;
  final ILocalSettingsService iLocalSettingsService;
  SubjectsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
    required this.storageSyncService,
    required this.iLocalSettingsService,
  });

  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final List<Map<String, dynamic>> aynaaSubjects = await dataBase.getData(
        path: DbEnpoints.subjects,
        query: {kVersionID: versionID, kIsDeleted: false});
    updateLastFetchedItemsTime(itemType: Entities.subjects);
    List<SubjectsEntity> subjects =
        mapToListOfEntity(aynaaSubjects, Entities.subjects);

    iLocalDbService.putAll<SubjectsEntity>(
      items: subjects,
      collentionType: Entities.subjects,
    );
    storageSyncService.donwloadInBauckground(subjects, Entities.subjects);
    return subjects;
  }

  @override
  Future<void> syncDB({required String versionID}) async {
    final settings = await iLocalSettingsService.getSettings();
    storageSyncService.syncDB<SubjectsEntity>(
      path: DbEnpoints.subjects,
      entityType: Entities.subjects,
      updtatedItemsQuery: {
        kVersionID: versionID,
        kUpdatedAt: {
          DbFilterTypes.greaterThan: settings!.lastTimeSubjectsFetched
        }
      },
      deletedItemsQuery: {kVersionID: versionID, kIsDeleted: true},
      lastTimeItemsFetched: settings.lastTimeVersionsFetched!,
    );
  }
}
