import 'dart:async';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';

abstract class VersionsLocalDataSource {
  Future<List<AynaaVersionsEntity>> fetchVersion();
  Future<void> handleUpdate(AynaaVersionsEntity versions);
  Stream<List<AynaaVersionsEntity>> get versionsStream;
}

class VersionsLocalDataSourceImpl implements VersionsLocalDataSource {
  final IsarStorageService isarStorageService;
  VersionsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<AynaaVersionsEntity>> fetchVersion() async {
    final versions = await isarStorageService.getAll(
        collentionType: CollentionType.versions);
    return versions as List<AynaaVersionsEntity>;
  }

  final _controller = StreamController<List<AynaaVersionsEntity>>.broadcast();

  @override
  Stream<List<AynaaVersionsEntity>> get versionsStream => _controller.stream;

  @override
  Future<void> handleUpdate(AynaaVersionsEntity versions) async {
    await isarStorageService.put(
      item: versions,
      collentionType: CollentionType.versions,
    );
    /* final newVersions = await hiveCache.getAll(boxName: kVersionsBox)
        as List<AynaaVersionsEntity>;
    _controller.add(newVersions);*/
  }

  void dispose() {
    _controller.close();
  }
}
