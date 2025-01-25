import 'package:hive_flutter/hive_flutter.dart';

abstract class HiveCache<T extends HiveObject> {
  /// Initialize the cache (register adapters and open boxes)
  Future<void> init();

  /// Get the Hive box name for this cache
  String get boxName;

  /// Get all cached items
  Future<List<T>> getAll();

  /// Get a single item by ID
  Future<T?> get(String id);

  /// Add new items to cache
  Future<void> add(List<T> items);

  /// Update existing items
  Future<void> update(List<T> items);

  /// Delete items by IDs
  Future<void> delete(List<String> ids);

  /// Clear entire cache
  Future<void> clear();

  /// Watch for changes in the cache
  Stream<BoxEvent> watch(String? id);

  /// Watch all items in cache
  Stream<List<T>> watchAll();

  /// Get cached items with pagination
  Future<List<T>> paginate({int page = 1, int limit = 20});

  /// Check if item exists in cache
  Future<bool> exists(String id);
}
