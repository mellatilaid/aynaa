import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/hive_service.dart';
import 'package:atm_app/features/admin/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

import '../../../../../../core/utils/db_enpoints.dart';

abstract class AynaaVersionsRemoteDataSource {
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions();
}

class AynaaVersionsRemoteDataSourceImpl
    implements AynaaVersionsRemoteDataSource {
  final DataBase dataBase;
  final HiveCache hiveCache;
  AynaaVersionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.hiveCache,
  });
  @override
  Future<List<AynaaVersionsEntity>> fetchAynaaVersions() async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getData(path: DbEnpoints.aynaaVersions);

    List<AynaaVersionsEntity> versions =
        convertToAynaaVersionEntity(aynaaVersions);
    hiveCache.add(boxName: kVersionsBox, items: versions);
    return versions;
  }

  List<AynaaVersionsEntity> convertToAynaaVersionEntity(
      List<Map<String, dynamic>> versions) {
    final List<AynaaVersionsEntity> aynaaVersions = versions.map((item) {
      return AynaaVersionsModel.fromSupabase(item);
    }).toList();
    return aynaaVersions;
  }
}
