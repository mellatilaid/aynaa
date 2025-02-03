import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/enums/entities.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_storage_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../core/utils/db_enpoints.dart';

abstract class AynaaVersionsRemoteDataSource {
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions();
}

class AynaaVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final LocalCacheService hiveCache;
  AynaaVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.hiveCache,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getData(path: DbEnpoints.aynaaVersions);

    List<AynaaVersionsEntity> versions =
        mapToListOfEntity(aynaaVersions, Entities.version);
    hiveCache.add(boxName: kVersionsBox, items: versions);
    return versions;
  }
}
