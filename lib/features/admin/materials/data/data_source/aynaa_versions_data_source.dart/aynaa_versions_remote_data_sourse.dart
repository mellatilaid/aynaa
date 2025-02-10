import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../core/services/background_services.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

abstract class AynaaVersionsRemoteDataSource {
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions();
}

class AynaaVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final IsarStorageService isarStorageService;
  AynaaVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.isarStorageService,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getData(path: DbEnpoints.aynaaVersions);

    List<AynaaVersionsEntity> versions =
        mapToListOfEntity(aynaaVersions, Entities.version);
    isarStorageService.putAll(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<BackgroundServices<AynaaVersionsEntity>>()
        .startBackgroundDownloads(versions);
    return versions;
  }
}
