// Global index cache

import 'dart:developer';

import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';

Map<String, Map<String, List<LessonEntity>>> indexCache = {};
//Map<String, dynamic>
void ensureIndex(String versionID, [String? subjectID]) {
  if (!indexCache.containsKey(versionID)) {
    indexCache[versionID] = {}; // Create version entry
  }
  if (subjectID != null) {
    indexCache[versionID]!
        .putIfAbsent(subjectID, () => []); // Ensure subject exists
  }
}

void putIndex<T>(
    String versionID, String? subjectID, List<LessonEntity> items) {
  ensureIndex(versionID, subjectID);

  if (subjectID != null) {
    indexCache[versionID]![subjectID]!.addAll(items);
  }
  items.map((e) {
    indexCache[versionID]!.putIfAbsent(e.toString(), () => []);
  });
}

List<LessonEntity> getIndex<T>(
  String versionID,
  String? subjectID,
) {
  ensureIndex(versionID, subjectID);

  if (subjectID != null) {
    log(indexCache[versionID]![subjectID]!.toString());
    return indexCache[versionID]![subjectID]!;
  }
  return [];
  //return indexCache[versionID]!.keys.toList();
}

/*final Map<String, Map<String, Map<dynamic, Set<dynamic>>>> indexCache = {};

// Ensure that an index for a given box and property exists.
void ensureIndex(String boxName, String propertyKey) {
  if (!indexCache.containsKey(boxName)) {
    indexCache[boxName] = {};
  }
  if (!indexCache[boxName]!.containsKey(propertyKey)) {
    indexCache[boxName]![propertyKey] = {};
  }
}

// When you add an object, update the index.
void updateIndex<T>(String boxName, T item, String propertyKey) {
  ensureIndex(boxName, propertyKey);
  // Retrieve the property value using your propertyAccessor
  final propertyValue = propertyAccessor(item, propertyKey);

  // Get or create the set for this property value
  final Map<dynamic, Set<dynamic>> propertyIndex =
      indexCache[boxName]![propertyKey]!;
  if (!propertyIndex.containsKey(propertyValue)) {
    propertyIndex[propertyValue] = <T>{};
  }
  propertyIndex[propertyValue]!.add(item);
}*/
