import 'dart:async';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/hive_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

abstract class VersionsLocalDataSource {
  Future<List<AynaaVersionsEntity>> fetchVersion();
  Future<void> handleUpdate(List<AynaaVersionsEntity> versions);
  Stream<List<AynaaVersionsEntity>> get versionsStream;
}

class VersionsLocalDataSourceImpl implements VersionsLocalDataSource {
  final HiveCache hiveCache;
  VersionsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<AynaaVersionsEntity>> fetchVersion() async {
    final versions = await hiveCache.getAll(boxName: 'versions');
    return versions as List<AynaaVersionsEntity>;
  }

  final _controller = StreamController<List<AynaaVersionsEntity>>.broadcast();

  @override
  Stream<List<AynaaVersionsEntity>> get versionsStream => _controller.stream;

  @override
  Future<void> handleUpdate(List<AynaaVersionsEntity> versions) async {
    await hiveCache.add(boxName: kVersionsBox, items: versions);
    final newVersions = await hiveCache.getAll(boxName: kVersionsBox)
        as List<AynaaVersionsEntity>;
    _controller.add(newVersions);
  }

  void dispose() {
    _controller.close();
  }
}
