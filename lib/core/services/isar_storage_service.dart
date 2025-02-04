import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../enums/entities.dart';

class IsarStorageService {
  late Isar _isar;
  Future<void> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          AynaaVersionsEntitySchema,
          LessonEntitySchema,
          SubjectsEntitySchema,
        ],
        directory: dir.path,
      );
    }
  }

  /// Get all cached items
  Future<List<dynamic>> getAll({
    required CollentionType collentionType,
  }) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        return _isar.aynaaVersionsEntitys.where().findAll();
      case CollentionType.versions:
        return _isar.aynaaVersionsEntitys.where().findAll();
      case CollentionType.subjects:
        return _isar.subjectsEntitys.where().findAll();
    }
  }

  /// Get a single item by ID
  Future<dynamic> get(String id) {
    throw UnimplementedError();
  }

  Future<void> putAll({
    required List<dynamic> items,
    required CollentionType collentionType,
  }) async {
    await init();

    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys.putAll(items as List<LessonEntity>);
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys
              .putAll(items as List<AynaaVersionsEntity>);
        });
      case CollentionType.subjects:
        await _isar.writeTxn(
          () async {
            await _isar.subjectsEntitys.putAll(items as List<SubjectsEntity>);
          },
        );
    }
  }

  Future<void> put(
      {required dynamic item, required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys.put(item as LessonEntity);
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys.put(item as AynaaVersionsEntity);
        });
      case CollentionType.subjects:
        await _isar.writeTxn(() async {
          await _isar.subjectsEntitys.put(item as SubjectsEntity);
        });
    }
  }

  /// Delete items by IDs
  Future<void> delete(
      {required String id, required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys.filter().entityIDEqualTo(id).deleteAll();
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys
              .filter()
              .entityIDEqualTo(id)
              .deleteAll();
        });
      case CollentionType.subjects:
        await _isar.writeTxn(() async {
          await _isar.subjectsEntitys.filter().entityIDEqualTo(id).deleteAll();
        });
    }
  }

  filter(
      {required Map<String, dynamic> query,
      required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        final result = await _isar.lessonEntitys
            .filter()
            .aynaaVersionIdEqualTo(query[kVersionID])
            .and()
            .group((q) => q.subjectIdEqualTo(query[kSubjectID]))
            .findAll();
        return result;
      case CollentionType.versions:
      case CollentionType.subjects:
        final result = await _isar.subjectsEntitys
            .filter()
            .versionIDEqualTo(query[kVersionID])
            .findAll();
        return result;
    }
  }

  /// Clear entire cache
  Future<void> clear({required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.lessonEntitys.clear();

      case CollentionType.versions:
        await _isar.aynaaVersionsEntitys.clear();
      case CollentionType.subjects:
        await _isar.subjectsEntitys.clear();
    }
  }

  /// Watch for changes in the cache
  //Stream<BoxEvent> watch(String? id) {}

  /// Watch all items in cache
  //Stream<List<dynamic>> watchAll() {}

  /// Get cached items with pagination
  //Future<List> paginate({int page = 1, int limit = 20}) {}

  /// Check if item exists in cache
  //Future<bool> exists(String id) {}
}
