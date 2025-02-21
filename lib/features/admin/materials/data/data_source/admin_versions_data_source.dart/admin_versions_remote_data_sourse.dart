import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';

import '../../../../../../core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import '../../../../../../core/services/storage_sync_service/storage_sync_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class AdminVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final LocalDBService localDB;
  final ILocalSettingsService iLocalSettingsService;
  AdminVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.localDB,
    required this.iLocalSettingsService,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    List<AynaaVersionsEntity> versions;

    final List<Map<String, dynamic>> aynaaVersions = await dataBase.getData(
      path: DbEnpoints.aynaaVersions,
    );
    versions = mapToListOfEntity(aynaaVersions, Entities.version);
    //update last time versions fetched from remote in settings
    _updateLocalDBSettings();

    localDB.putAll<AynaaVersionsEntity>(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<StorageSyncService<AynaaVersionsEntity>>()
        .donwloadInBauckground(versions);
    return versions;
  }

  @override
  Future<void> syncVersions() async {
    List<AynaaVersionsEntity> versions;
    final settings = await iLocalSettingsService.getSettings();
    final List<Map<String, dynamic>> updatedData = await dataBase.getData(
      path: DbEnpoints.aynaaVersions,
      filterComparison: FilterComparison.greaterThan,
      query: {kUpdatedAt: settings!.lastTimeVersionsFetched},
    );
    final List<Map<String, dynamic>> deletedItems = await dataBase.getData(
      path: DbEnpoints.aynaaVersions,
      filterComparison: FilterComparison.equal,
      query: {kIsDeleted: true},
    );

    if (updatedData.isNotEmpty) {
      versions = mapToListOfEntity(updatedData, Entities.version);
      //update last time versions fetched from remote in settings
      _updateLocalDBSettings();

      localDB.putAll<AynaaVersionsEntity>(
          items: versions, collentionType: CollentionType.versions);
      getit
          .get<StorageSyncService<AynaaVersionsEntity>>()
          .donwloadInBauckground(versions);
    }
    if (deletedItems.isNotEmpty) {
      versions = mapToListOfEntity(updatedData, Entities.version);
    }
  }

  _updateLocalDBSettings() async {
    final settings = await iLocalSettingsService.getSettings();
    settings!.lastTimeVersionsFetched =
        DateTime.now().toUtc().toIso8601String();
    await iLocalSettingsService.updateSettings(settingsEntity: settings);
  }
}
