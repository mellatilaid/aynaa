import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/db_filter_types.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';

class AdminExamSectionsRemoteDataSourceImpl
    extends ExamSectionsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final IDBSyncService idbSyncService;
  final ILocalSettingsService iLocalSettingsService;
  AdminExamSectionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.idbSyncService,
    required this.iLocalDbService,
    required this.iLocalSettingsService,
  });

  @override
  Future<List<ExamSectionsEntity>> fetchExamSections(
      {required String examID}) async {
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.examSections, query: {
      kExamID: examID,
      kIsDeleted: false,
    });

    List<ExamSectionsEntity> items =
        mapToListOfEntity(data, Entities.examSections);
    iLocalDbService.putAll<ExamSectionsEntity>(items: items);
    idbSyncService.donwloadInBauckground(items, Entities.examSections);
    updateLastFetchedItemsTime(itemType: Entities.examSections);
    return items;
  }

  @override
  Future<void> syncSections({required String examID}) async {
    final settings = await iLocalSettingsService.getSettings();
    idbSyncService.syncDB<ExamSectionsEntity>(
      path: DbEnpoints.examSections,
      entityType: Entities.examSections,
      updtatedItemsQuery: {
        kExamID: examID,
        kUpdatedAt: {
          DbFilterTypes.greaterThan: settings!.lastTimeSectionsFetched
        }
      },
      deletedItemsQuery: {kExamID: examID, kIsDeleted: true},
      lastTimeItemsFetched: settings.lastTimeSectionsFetched!,
    );
  }
}
