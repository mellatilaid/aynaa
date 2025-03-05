import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/db_filter_types.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';

abstract class ExamsRemoteDataSource {
  Future<List<ExamEntity>> fetchExams({required String versionID});
  Future<void> syncExams({required String versionID});
}

class ExamsRemoteDataSourceImpl extends ExamsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final IDBSyncService idbSyncService;
  final ILocalSettingsService iLocalSettingsService;

  ExamsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
    required this.idbSyncService,
    required this.iLocalSettingsService,
  });

  @override
  Future<List<ExamEntity>> fetchExams({required String versionID}) async {
    final List<Map<String, dynamic>> data = await dataBase.getData(
        path: DbEnpoints.exams,
        query: {kVersionID: versionID, kIsDeleted: false});

    List<ExamEntity> items = mapToListOfEntity(data, Entities.exam);
    iLocalDbService.putAll<ExamEntity>(
        items: items, collentionType: Entities.exam);
    idbSyncService.donwloadInBauckground(items, Entities.exam);
    return items;
  }

  @override
  Future<void> syncExams({required String versionID}) async {
    final settings = await iLocalSettingsService.getSettings();
    idbSyncService.syncDB<ExamEntity>(
      path: DbEnpoints.exams,
      entityType: Entities.exam,
      updtatedItemsQuery: {
        kVersionID: versionID,
        kUpdatedAt: {DbFilterTypes.greaterThan: settings!.lastTimeExamsFetched}
      },
      deletedItemsQuery: {kVersionID: versionID, kIsDeleted: true},
      lastTimeItemsFetched: settings.lastTimeExamsFetched!,
    );
  }
}
