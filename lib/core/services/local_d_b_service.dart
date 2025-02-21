import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../helper/enums.dart';

class LocalDBService {
  final Isar _isar;

  LocalDBService(this._isar);
  Future<void> init() async {
    /* if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [
          AynaaVersionsEntitySchema,
          LessonEntitySchema,
          SubjectsEntitySchema,
          DeletedItmesEntitySchema,
          ExamEntitySchema,
          SettingsEntitySchema,
        ],
        directory: dir.path,
      );
    }*/
  }

  /// Get all cached items
  Future<List<E>> getAll<E>() async {
    await init();
    try {
      final collection = _isar.collection<E>();
      final items = await collection.where().findAll();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single item by ID
  Future<E?> get<E>({required String id}) async {
    try {
      final collection = _isar.collection<E>();
      final item = await collection.getByIndex(kIndexBy, [id]);
      return item;
    } catch (e) {
      rethrow;
    }
    /*switch (collentionType) {
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
      case CollentionType.exam:
        return await _isar.examEntitys.getByEntityID(id);
    }*/
  }

  Future<String> getIsarPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> putAll<E>({
    required List<dynamic> items,
    required CollentionType collentionType,
  }) async {
    await init();
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.putAllByIndex(kIndexBy, items as List<E>);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> put<E>({required dynamic item}) async {
    await init();
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.putByIndex(kIndexBy, item as E);
      });
    } catch (e) {
      rethrow;
    }
  }

  /// Delete items by IDs
  Future<void> delete<E>(
      {required String id, required CollentionType collentionType}) async {
    await init();
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.deleteByIndex(kIndexBy, [id]);
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAll<E>(
      {required List<Id> ids, required CollentionType collentionType}) async {
    await init();
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.deleteAll(ids);
      });
    } catch (e) {
      rethrow;
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
      case CollentionType.exam:
        final result = await _isar.examEntitys
            .filter()
            .versionIDEqualTo(query[kVersionID])
            .findAll();
        return result;
      case CollentionType.deletedItmes:
    }
  }

  /// Clear entire cache
  Future<void> clear<E>({required CollentionType collentionType}) async {
    await init();
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.clear();
      });
    } catch (e) {
      rethrow;
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
      case CollentionType.exam:
        Stream<void> subjectsStream = _isar.examEntitys.watchLazy();
        yield* subjectsStream.asyncMap((_) async {
          return await _isar.examEntitys
              .where()
              .filter()
              .versionIDEqualTo(id!)
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
        final deletedVersion = await get(id: id);
        if (deletedVersion != null) {
          deletedVersion.isDeleted = true;
          await put(
            item: deletedVersion,
            //collentionType: CollentionType.versions,
          );
        }
        final itemDeleted = DeletedItmesEntity(id, true, false);
        _isar.deletedItmesEntitys.putByIndex('itemID', itemDeleted);
      case CollentionType.subjects:
        final deletedSubject = await get(id: id);
        if (deletedSubject != null) {
          deletedSubject.isDeleted = true;
          await put(
            item: deletedSubject,
            // collentionType: CollentionType.subjects,
          );
        }
      case CollentionType.exam:
        final deletedSubject = await get(id: id);
        if (deletedSubject != null) {
          deletedSubject.isDeleted = true;
          await put(
            item: deletedSubject,
            //collentionType: CollentionType.exam,
          );
        }
      case CollentionType.deletedItmes:
    }
  }
}
