import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../helper/enums.dart';

class LocalDbService extends ILocalDbService {
  final Isar _isar;

  LocalDbService(this._isar);

  /// Get all cached items
  @override
  Future<List<E>> getAll<E>() async {
    try {
      final collection = _isar.collection<E>();
      final items = await collection.where().findAll();
      return items;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single item by ID
  @override
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

  @override
  Future<String> getIsarPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  @override
  Future<void> putAll<E>({
    required List<dynamic> items,
    Entities? collentionType,
  }) async {
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.putAllByIndex(kIndexBy, items as List<E>);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> put<E>({required dynamic item}) async {
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
  @override
  Future<void> delete<E>({required String id}) async {
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.deleteByIndex(kIndexBy, [id]);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAll<E>({required List<Id> ids}) async {
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.deleteAll(ids);
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  filter(
      {required Map<String, dynamic> query,
      required Entities collentionType}) async {
    switch (collentionType) {
      case Entities.lessons:
        final result = await _isar.lessonEntitys
            .filter()
            .aynaaVersionIdEqualTo(query[kVersionID])
            .and()
            .group((q) => q.subjectIdEqualTo(query[kSubjectID]))
            .findAll();
        final number = await _isar.lessonEntitys.count();
        log(number.toString());
        return result;
      case Entities.versions:
      case Entities.subjects:
        final result = await _isar.subjectsEntitys
            .filter()
            .versionIDEqualTo(query[kVersionID])
            .and()
            .group((q) => q.isDeletedEqualTo(false))
            .findAll();
        return result;
      case Entities.exam:
        final result = await _isar.examEntitys
            .filter()
            .versionIDEqualTo(query[kVersionID])
            .findAll();
        return result;
      case Entities.questions:
      case Entities.examSections:
        final result = await _isar.examSectionsEntitys
            .filter()
            .examIDEqualTo(query[kExamID])
            .findAll();
        return result;
    }
  }

  /// Clear entire cache
  @override
  Future<void> clear<E>() async {
    try {
      final collection = _isar.collection<E>();
      await _isar.writeTxn(() async {
        await collection.clear();
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<T>> watchAll<T>(
      {required Entities collectionType, String? id}) async* {
    // Ensure Isar is initialized

    switch (collectionType) {
      case Entities.lessons:
        Stream<void> lessonStream = _isar.lessonEntitys.watchLazy();

        yield* lessonStream.asyncMap((_) async {
          return await _isar.lessonEntitys
              .where()
              .filter()
              .subjectIdEqualTo(id!)
              .findAll() as List<T>; // Fetch updated data
        });

      case Entities.versions:
        Stream<void> versionsStream = _isar.aynaaVersionsEntitys.watchLazy();
        yield* versionsStream.asyncMap((_) async {
          return await _isar.aynaaVersionsEntitys.where().findAll() as List<T>;
        });

      case Entities.subjects:
        Stream<void> subjectsStream = _isar.subjectsEntitys.watchLazy();
        yield* subjectsStream.asyncMap((_) async {
          return await _isar.subjectsEntitys
              .where()
              .filter()
              .versionIDEqualTo(id!)
              .group((q) => q.isDeletedEqualTo(false))
              .findAll() as List<T>;
        });
      case Entities.exam:
        Stream<void> subjectsStream = _isar.examEntitys.watchLazy();
        yield* subjectsStream.asyncMap((_) async {
          return await _isar.examEntitys
              .where()
              .filter()
              .versionIDEqualTo(id!)
              .findAll() as List<T>;
        });

      case Entities.questions:
      case Entities.examSections:
        Stream<void> stream = _isar.examSectionsEntitys.watchLazy();
        yield* stream.asyncMap((_) async {
          return await _isar.examSectionsEntitys
              .where()
              .filter()
              .examIDEqualTo(id!)
              .findAll() as List<T>;
        });
    }
  }

  @override
  Future<void> markAsDeleted(
      {required String id, required Entities collentionType}) async {
    switch (collentionType) {
      case Entities.lessons:
      case Entities.versions:
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
      case Entities.subjects:
        final deletedSubject = await get(id: id);
        if (deletedSubject != null) {
          deletedSubject.isDeleted = true;
          await put(
            item: deletedSubject,
            // collentionType: CollentionType.subjects,
          );
        }
      case Entities.exam:
        final deletedSubject = await get(id: id);
        if (deletedSubject != null) {
          deletedSubject.isDeleted = true;
          await put(
            item: deletedSubject,
            //collentionType: CollentionType.exam,
          );
        }
      case Entities.questions:
      case Entities.examSections:
    }
  }
}
