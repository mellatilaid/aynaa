import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_db_service/local_d_b_service.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../core/services/db_sync_service/db_sync_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../../../common/versions/data/data_source/versions_data_source/versions_remote_data_source.dart';

class StudentVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final LocalDbService isarStorageService;
  StudentVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.isarStorageService,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getData(path: DbEnpoints.aynaaVersions);

    List<AynaaVersionsEntity> versions =
        mapToListOfEntity(aynaaVersions, Entities.versions);
    isarStorageService.putAll(
        items: versions, collentionType: Entities.versions);
    getit
        .get<DBSyncService<AynaaVersionsEntity>>()
        .donwloadInBauckground(versions);
    return versions;
  }

  @override
  Future<void> syncVersions() {
    // TODO: implement syncVersions
    throw UnimplementedError();
  }
}
