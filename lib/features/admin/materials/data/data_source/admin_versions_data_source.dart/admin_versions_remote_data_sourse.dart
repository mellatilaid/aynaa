import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_settings_service/i_local_settings_service.dart';
import 'package:atm_app/core/services/storage_sync_service/I_storage_sync_service.dart';

import '../../../../../../core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import '../../../../../../core/utils/db_enpoints.dart';

class AdminVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService localDB;
  final ILocalSettingsService iLocalSettingsService;
  final IStorageSyncService iStorageSyncService;
  AdminVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.localDB,
    required this.iLocalSettingsService,
    required this.iStorageSyncService,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    List<AynaaVersionsEntity> versions;

    final List<Map<String, dynamic>> aynaaVersions = await dataBase.getData(
      path: DbEnpoints.aynaaVersions,
      query: {kIsDeleted: false},
    );
    versions = mapToListOfEntity(aynaaVersions, Entities.version);
    //update last time versions fetched from remote in settings
    _updateLocalDBSettings();

    localDB.putAll<AynaaVersionsEntity>(
        items: versions, collentionType: CollentionType.versions);
    iStorageSyncService.donwloadInBauckground(
        versions, CollentionType.versions);

    return versions;
  }

  @override
  Future<void> syncVersions() async {
    List<AynaaVersionsEntity> items;
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
      items = mapToListOfEntity(updatedData, Entities.version);
      //update last time versions fetched from remote in settings
      _updateLocalDBSettings();

      localDB.putAll<AynaaVersionsEntity>(
          items: items, collentionType: CollentionType.versions);
      iStorageSyncService.donwloadInBauckground(items, CollentionType.versions);
    }
    if (deletedItems.isNotEmpty) {
      items = mapToListOfEntity(deletedItems, Entities.version);
      iStorageSyncService.deleteInBauckground(items, DeletedItemType.version);
    }
  }

  _updateLocalDBSettings() async {
    final settings = await iLocalSettingsService.getSettings();
    settings!.lastTimeVersionsFetched =
        DateTime.now().toUtc().toIso8601String();
    await iLocalSettingsService.updateSettings(settingsEntity: settings);
  }
}
