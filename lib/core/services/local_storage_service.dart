import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalCacheService<T extends HiveObject> {
  /// Initialize the cache (register adapters and open boxes)
  Future<void> init({required String boxName});

  /// Get the Hive box name for this cache
  String get boxName;

  /// Get all cached items
  Future<List<T>> getAll({
    required String boxName,
    Map<String, dynamic> query = const {},
    List<String> indexedKeys = const [],
  });

  /// Get a single item by ID
  Future<T?> get(String boxName, String id);

  /// Add new items to cache

  Future<void> add({required String boxName, required List<T> items});

  Future<void> putAll({
    required String boxName,
    required List<T> items,
    Map<String, dynamic> query = const {},
  });
  Future<void> put(
      {required String boxName, required T item, required String id});

  /// Update existing items
  Future<void> update(List<T> items);

  /// Delete items by IDs
  Future<void> delete(List<String> ids);

  /// Clear entire cache
  Future<void> clear({required String boxName});

  /// Watch for changes in the cache
  Stream<BoxEvent> watch(String? id);

  /// Watch all items in cache
  Stream<List<T>> watchAll();

  /// Get cached items with pagination
  Future<List<T>> paginate({int page = 1, int limit = 20});

  /// Check if item exists in cache
  Future<bool> exists(String id);
}
