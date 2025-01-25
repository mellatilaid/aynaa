import 'package:atm_app/core/services/hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class BaseHiveCache<T extends HiveObject> implements HiveCache<T> {
  late Box<T> _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox<T>(boxName);
  }

  @override
  Future<List<T>> getAll() async {
    return _box.values.toList();
  }

  @override
  Future<T?> get(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> add(List<T> items) async {
    await _box.addAll(items);
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
}
