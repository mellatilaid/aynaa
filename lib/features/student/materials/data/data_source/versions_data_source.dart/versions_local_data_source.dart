import 'dart:async';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';

class StudentVersionsLocalDataSourceImpl implements VersionsLocalDataSource {
  final IsarStorageService isarStorageService;
  StudentVersionsLocalDataSourceImpl({required this.isarStorageService});
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
  Future<void> handleUpdate(
      {AynaaVersionsEntity? version,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put(
            item: version, collentionType: CollentionType.versions);
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
        await isarStorageService.delete(
            id: id!, collentionType: CollentionType.versions);
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
