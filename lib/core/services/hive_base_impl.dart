import 'dart:developer';

import 'package:atm_app/core/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BaseHiveCache<T extends HiveObject> implements HiveCache<T> {
  late Box<T> _box;

  @override
  Future<void> init({required String boxName}) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
      log('box is  opened');
    }
  }

  @override
  Future<List<T>> getAll({required String boxName}) async {
    await init(boxName: boxName);
    var box = Hive.box<T>(boxName);
    log(box.values.length.toString());
    return box.values.toList();
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
  Future<void> clear() async {
    await _box.clear();
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
}
