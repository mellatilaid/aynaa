import 'package:atm_app/core/common/settings_entity.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_background_sync.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';

import '../../../../../../core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import '../../../../../../core/services/background_services.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class AdminVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final LocalDBService localDB;
  AdminVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.localDB,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getData(path: DbEnpoints.aynaaVersions);

    List<AynaaVersionsEntity> versions =
        mapToListOfEntity(aynaaVersions, Entities.version);

    localDB.putAll<AynaaVersionsEntity>(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<BackgroundServices<AynaaVersionsEntity>>()
        .startBackgroundDownloads(versions);
    return versions;
  }

  @override
  Future<void> syncVersions() async {
    // TODO: implement syncVersions
    final String isarPath = await localDB.getIsarPath();
    syncDataInBackground(IsolateSyncParams(
      isarPath: isarPath,
      tableName: 'subjects',
      fetchRemoteData: () async =>
          await dataBase.getData(path: DbEnpoints.aynaaVersions),
      fetchAllIds: () async => await dataBase.getData(
          path: DbEnpoints.aynaaVersions, columns: kUuid),
      fromJson: (json) => AynaaVersionsModel.fromJson(json),
    ));
  }

  _updateLocalDBSettings() async {
    final settings = await localDB.get<SettingsEntity>(
        id: '0', collentionType: CollentionType.lessons);
  }
}
