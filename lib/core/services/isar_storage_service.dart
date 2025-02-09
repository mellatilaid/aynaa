import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../helper/enums.dart';

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
          DeletedItmesEntitySchema,
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
      case CollentionType.deletedItmes:
        return _isar.deletedItmesEntitys.where().findAll();
    }
  }

  /// Get a single item by ID
  Future<dynamic> get(
      {required String id, required CollentionType collentionType}) async {
    await init();

    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          return await _isar.lessonEntitys.getByEntityID(id);
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          return await _isar.aynaaVersionsEntitys.getByEntityID(id);
        });
      case CollentionType.subjects:
        return await _isar.subjectsEntitys.getByEntityID(id);
        await _isar.writeTxn(
          () async {},
        );
      case CollentionType.deletedItmes:
    }
  }

  Future<void> putAll({
    required List<dynamic> items,
    required CollentionType collentionType,
  }) async {
    await init();

    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys
              .putAllByEntityID(items as List<LessonEntity>);
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys
              .putAllByEntityID(items as List<AynaaVersionsEntity>);
        });
      case CollentionType.subjects:
        await _isar.writeTxn(
          () async {
            await _isar.subjectsEntitys
                .putAllByEntityID(items as List<SubjectsEntity>);
          },
        );
      case CollentionType.deletedItmes:
    }
  }

  Future<void> put(
      {required dynamic item, required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        log('i am trigrred again ${_isar.lessonEntitys.count().toString()}');
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys
              .putByIndex('entityID', item as LessonEntity);
        });
        log(_isar.lessonEntitys.count().toString());
        log('item added to isar');
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys
              .putByIndex('entityID', item as AynaaVersionsEntity);
        });
      case CollentionType.subjects:
        await _isar.writeTxn(
          () async {
            await _isar.subjectsEntitys
                .putByIndex('entityID', item as SubjectsEntity);
          },
        );
      case CollentionType.deletedItmes:
        await _isar.writeTxn(
          () async {
            await _isar.deletedItmesEntitys
                .putByIndex('itemID', item as DeletedItmesEntity);
          },
        );
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
      case CollentionType.deletedItmes:
        await _isar.writeTxn(
          () async {
            await _isar.deletedItmesEntitys
                .filter()
                .itemIDEqualTo(id)
                .deleteAll();
          },
        );
    }
  }

  Future<void> deleteAll(
      {required List<Id> ids, required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys.deleteAll(ids);
        });
      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys.deleteAll(ids);
        });
      case CollentionType.subjects:
        await _isar.writeTxn(() async {
          await _isar.subjectsEntitys.deleteAll(ids);
        });
      case CollentionType.deletedItmes:
        await _isar.writeTxn(() async {
          await _isar.deletedItmesEntitys.deleteAll(ids);
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
        final number = await _isar.lessonEntitys.count();
        log(number.toString());
        return result;
      case CollentionType.versions:
      case CollentionType.subjects:
        final result = await _isar.subjectsEntitys
            .filter()
            .versionIDEqualTo(query[kVersionID])
            .and()
            .group((q) => q.isDeletedEqualTo(false))
            .findAll();
        return result;
      case CollentionType.deletedItmes:
    }
  }

  /// Clear entire cache
  Future<void> clear({required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
        await _isar.writeTxn(() async {
          await _isar.lessonEntitys.clear();
        });

      case CollentionType.versions:
        await _isar.writeTxn(() async {
          await _isar.aynaaVersionsEntitys.clear();
        });

      case CollentionType.subjects:
        await _isar.writeTxn(() async {
          await _isar.subjectsEntitys.clear();
        });
      case CollentionType.deletedItmes:
    }
  }

  Stream<List<T>> watchAll<T>(
      {required CollentionType collectionType, String? id}) async* {
    await init(); // Ensure Isar is initialized

    switch (collectionType) {
      case CollentionType.lessons:
        Stream<void> lessonStream = _isar.lessonEntitys.watchLazy();
        yield* lessonStream.asyncMap((_) async {
          return await _isar.lessonEntitys
              .where()
              .filter()
              .subjectIdEqualTo(id!)
              .findAll() as List<T>; // Fetch updated data
        });

      case CollentionType.versions:
        Stream<void> versionsStream = _isar.aynaaVersionsEntitys.watchLazy();
        yield* versionsStream.asyncMap((_) async {
          return await _isar.aynaaVersionsEntitys.where().findAll() as List<T>;
        });

      case CollentionType.subjects:
        Stream<void> subjectsStream = _isar.subjectsEntitys.watchLazy();
        yield* subjectsStream.asyncMap((_) async {
          return await _isar.subjectsEntitys
              .where()
              .filter()
              .versionIDEqualTo(id!)
              .group((q) => q.isDeletedEqualTo(false))
              .findAll() as List<T>;
        });

      case CollentionType.deletedItmes:
    }
  }

  Future<void> markAsDeleted(
      {required String id, required CollentionType collentionType}) async {
    await init();
    switch (collentionType) {
      case CollentionType.lessons:
      case CollentionType.versions:
        final deletedVersion =
            await get(id: id, collentionType: CollentionType.versions);
        if (deletedVersion != null) {
          deletedVersion.isDeleted = true;
          await put(
            item: deletedVersion,
            collentionType: CollentionType.versions,
          );
        }
        final itemDeleted = DeletedItmesEntity(id, true, false);
        _isar.deletedItmesEntitys.putByIndex('itemID', itemDeleted);
      case CollentionType.subjects:
        final deletedSubject =
            await get(id: id, collentionType: CollentionType.subjects);
        if (deletedSubject != null) {
          deletedSubject.isDeleted = true;
          await put(
            item: deletedSubject,
            collentionType: CollentionType.subjects,
          );
        }
      case CollentionType.deletedItmes:
    }
  }

  /// Watch for changes in the cache
  //Stream<BoxEvent> watch(String? id) {}

  /// Watch all items in cache

  /// Get cached items with pagination
  //Future<List> paginate({int page = 1, int limit = 20}) {}

  /// Check if item exists in cache
  //Future<bool> exists(String id) {}
}
