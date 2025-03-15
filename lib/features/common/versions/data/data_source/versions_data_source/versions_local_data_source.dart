import 'dart:async';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';

abstract class VersionsLocalDataSource {
  Future<List<AynaaVersionsEntity>> fetchVersion();

  Future<void> handleUpdate(
      {AynaaVersionsEntity? version,
      String? id,
      required PostgressEventType eventType});
  Stream<List<AynaaVersionsEntity>> get versionsStream;
}

class VersionsLocalDataSourceImpl implements VersionsLocalDataSource {
  final ILocalDbService iLocalDbService;
  final IDBSyncService iStorageSyncService;
  VersionsLocalDataSourceImpl(
      {required this.iLocalDbService, required this.iStorageSyncService});
  @override
  Future<List<AynaaVersionsEntity>> fetchVersion() async {
    final versions = await iLocalDbService.getAll<AynaaVersionsEntity>();
    iStorageSyncService.donwloadInBauckground(versions, Entities.versions);
    return versions;
  }

  final _controller = StreamController<List<AynaaVersionsEntity>>.broadcast();

  @override
  Stream<List<AynaaVersionsEntity>> get versionsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {AynaaVersionsEntity? version,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await iLocalDbService.put<AynaaVersionsEntity>(item: version);
        /* final newLessons = await isarStorageService.filter(
          collentionType: CollentionType.lessons,
          query: {
            kVersionID: lesson!.aynaaVersionId,
            kSubjectID: lesson.subjectId
          },
        ) as List<LessonEntity>;
        _controller.add(newLessons);*/
        break;
      case PostgressEventType.delete:
        await iLocalDbService.delete<AynaaVersionsEntity>(id: id!);
        /*final newLessons = await isarStorageService.filter(
          collentionType: CollentionType.lessons,
          query: {
            kVersionID: lesson!.aynaaVersionId,
            kSubjectID: lesson.subjectId
          },
        ) as List<LessonEntity>;
        _controller.add(newLessons);*/
        break;
      default:
    }
    /* final newVersions = await hiveCache.getAll(boxName: kVersionsBox)
        as List<AynaaVersionsEntity>;
    _controller.add(newVersions);*/
  }

  void dispose() {
    _controller.close();
  }
}
