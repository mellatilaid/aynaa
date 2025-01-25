import 'package:atm_app/core/services/hive_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

abstract class VersionsLocalDataSource {
  Future<List<AynaaVersionsEntity>> fetchVersion();
}

class VersionsLocalDataSourceImpl implements VersionsLocalDataSource {
  final HiveCache hiveCache;
  VersionsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<AynaaVersionsEntity>> fetchVersion() async {
    final versions = await hiveCache.getAll(boxName: 'versions');
    return versions as List<AynaaVersionsEntity>;
  }
}
