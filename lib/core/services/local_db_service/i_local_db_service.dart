import 'package:atm_app/core/helper/enums.dart';
import 'package:isar/isar.dart';

abstract class ILocalDbService {
  Future<List<E>> getAll<E>();

  /// Get a single item by ID
  Future<E?> get<E>({required String id});

  Future<String> getIsarPath();
  Future<void> putAll<E>({
    required List<dynamic> items,
    Entities? collentionType,
  });

  Future<void> put<E>({required dynamic item});

  /// Delete items by IDs
  Future<void> delete<E>({required String id});

  Future<void> deleteAll<E>({required List<Id> ids});

  filter(
      {required Map<String, dynamic> query, required Entities collentionType});

  /// Clear entire cache
  Future<void> clear<E>();

  Stream<List<T>> watchAll<T>({required Entities collectionType, String? id});
  Future<void> markAsDeleted(
      {required String id, required Entities collentionType});
}
