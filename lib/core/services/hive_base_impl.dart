import 'dart:developer';

import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/local_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../functions/idexed_cache_helper.dart';

class BaseHiveCache<T> implements LocalCacheService<T> {
  late Box<T> _box;

  @override
  Future<void> init({required String boxName}) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);

      log('box is  opened $boxName');
    }
  }

  @override
  Future<List<T>> getAll({
    required String boxName,
    Map<String, dynamic> query = const {},
    List<String> indexedKeys = const [],
  }) async {
    await init(boxName: boxName);
    final box = Hive.box<T>(boxName);

    if (query.isEmpty) return box.values.toList();
    if (query[kSubjectID] == null) {
      return box.values.where((item) {
        final String value = propertyAccessor(item, kVersionID);
        return value == query[kVersionID];
      }).toList();
    }
    final resault = getIndex<T>(query[kVersionID], query[kSubjectID]);
    return resault as List<T>;
    return box.values.where((item) {
      return query.entries.every((entry) {
        final dynamic value = propertyAccessor(item, entry.value);
        return value == entry.value;
      });
    }).toList();
  }

  dynamic propertyAccessor<T>(T item, String propertyName) {
    switch (item) {
      case SubjectsEntity():
        return item.versionName;
      case LessonEntity():
        switch (propertyName) {
          case kSubjectID:
            return item.subjectId;
          case kVersionID:
            return item.aynaaVersionId;
          case kLessonID:
            return item.entityID;
        }
      default:
    }
  }

  @override
  Future<T?> get(String boxName, String id) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);
    return box.get(id);
  }

  @override
  Future<void> add({required String boxName, required List<T> items}) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);

    await box.addAll(items);
  }

  @override
  Future<void> update(List<T> items) async {}

  @override
  Future<void> delete(List<String> ids) async {
    await _box.deleteAll(ids);
  }

  @override
  Future<void> clear({required String boxName}) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);
    indexCache.clear();
    await box.clear();
  }

  @override
  Stream<BoxEvent> watch(String? id) {
    return _box.watch(key: id);
  }

  @override
  Stream<List<T>> watchAll() {
    return _box.watch().map((event) => _box.values.toList());
  }

  @override
  Future<List<T>> paginate({int page = 1, int limit = 20}) async {
    final start = (page - 1) * limit;
    final end = start + limit;
    return _box.values.toList().sublist(start, end);
  }

  @override
  Future<bool> exists(String id) async {
    return _box.containsKey(id);
  }

  @override
  // TODO: implement boxName
  String get boxName => throw UnimplementedError();

  @override
  Future<void> put(
      {required String boxName, required T item, required String id}) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);

    await box.put(id, item);
    if (boxName == kLessonsBox) {
      putIndex(
        propertyAccessor(item, kVersionID),
        propertyAccessor(item, kSubjectID),
        [item as LessonEntity],
      );
    }
  }

  @override
  Future<void> putAll({
    required String boxName,
    required List<T> items,
    Map<String, dynamic> query = const {},
  }) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);
    final map = _listToMap<T>(items);
    await box.putAll(map);
    if (query[kSubjectID] == null) return;
    putIndex<T>(
        query[kVersionID], query[kSubjectID], items as List<LessonEntity>);
  }
}

_listToMap<T>(List<T> items) {
  Map<dynamic, T> map = {};
  for (var item in items) {
    if (item is Entity) {
      map[item.entityID] = item;
    }
  }
  return map;
}
