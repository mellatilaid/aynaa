import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/services/local_storage_service.dart';
import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';
import 'package:flutter/foundation.dart';

import '../../features/admin/materials/domain/entities/lesson_entity.dart';
import '../const/local_db_const.dart';
import '../functions/idexed_cache_helper.dart';

/*class CachIndexLessonsInBackground {
  final HiveCache hiveCache;
  CachIndexLessonsInBackground({required this.hiveCache});
  Future<List<Map<String, dynamic>>> _loadAllLessons() async {
    final lessons = await hiveCache.getAll(boxName: kLessonsBox);
    return lessons.cast<LessonEntity>().map((e) => toMap(e)).toList();
  }

  Map<String, dynamic> toMap(LessonEntity lesson) {
    return {
      kName: lesson.name,
      kUrl: lesson.url,
      kContent: lesson.description,
      kVersionID: lesson.aynaaVersionId,
      kSubjectID: lesson.subjectId,
      kVersionName: lesson.versionName,
      kSubjectName: lesson.subjectName,
    };
  }

  Map<String, Map<String, List<LessonEntity>>> cacheIndexLessonsInBackgroud(
      List<Map<String, dynamic>> lessons) {
    final Map<String, Map<String, List<LessonEntity>>> cache = {};

    for (final lesson in lessons) {
      // Ensure the version exists.
      ensureIndex(lesson[kVersionID], lesson[kSubjectID]);
      // Ensure the subject exists within that version.
      putIndex(lesson[kVersionID], lesson[kSubjectID],
          [LessonModel.fromMap(lesson)]);
      // Add the lesson to the subject list.
      /*cache[lesson[kVersionID]]![lesson[kSubjectID]]!
          .add(LessonModel.fromMap(lesson));*/
    }

    return cache;
  }

  Future<void> initializeCacheInBackground() async {
    // Example: Load your lessons from the lessons box.
    // Replace this with your actual code to load the lessons.
    final allLessons = await _loadAllLessons();

    // Use compute to run processLessons in a background isolate.
    final Map<String, Map<String, List<LessonEntity>>> resultCache =
        await compute(cacheIndexLessonsInBackgroud, allLessons);
    log('index cach is ${indexCache.length.toString()}');

    // Now assign the processed cache to your global indexCache.
  }
}*/

class CachIndexLessonsInBackground {
  final LocalCacheService hiveCache;
  //static Map<String, Map<String, List<LessonEntity>>> indexCache = {};

  CachIndexLessonsInBackground({required this.hiveCache});

  Future<List<Map<String, dynamic>>> _loadAllLessons() async {
    final lessons = await hiveCache.getAll(boxName: kLessonsBox);

    return lessons.cast<LessonEntity>().map((e) {
      final item = toMap(e);

      return item;
    }).toList();
  }

  Map<String, dynamic> toMap(LessonEntity lesson) {
    return {
      kName: lesson.name,
      kUrl: lesson.url,
      kContent: lesson.description,
      kVersionID: lesson.aynaaVersionId,
      kSubjectID: lesson.subjectId,
      kVersionName: lesson.versionName,
      kSubjectName: lesson.subjectName,
      kLocalFilePath: lesson.localFilePath,
    };
  }

  // 1. Separate cache building logic
  static Map<String, Map<String, List<LessonEntity>>> _buildCacheIndex(
      List<Map<String, dynamic>> lessons) {
    final cache = <String, Map<String, List<LessonEntity>>>{};

    for (final lessonMap in lessons) {
      final lesson = LessonModel.fromMap(lessonMap);

      // 1. Validate and sanitize keys
      final versionId = _sanitizeKey(lessonMap[kVersionID]);
      final subjectId = _sanitizeKey(lessonMap[kSubjectID]);

      // 2. Skip invalid entries
      if (versionId.isEmpty || subjectId.isEmpty) {
        log('Skipping lesson ${lesson.id} - invalid version/subject ID');
        continue;
      }

      // 3. Initialize nested maps
      cache.putIfAbsent(versionId, () => <String, List<LessonEntity>>{});
      cache[versionId]!.putIfAbsent(subjectId, () => <LessonEntity>[]);

      cache[versionId]![subjectId]!.add(lesson);
    }

    // 5. Log final structure
    log('Cache Index Summary:');
    cache.forEach((version, subjects) {
      log('Version $version (${subjects.length} subjects)');
      subjects.forEach((subject, lessons) {
        log('- Subject $subject: ${lessons.length} lessons');
      });
    });

    return cache;
  }

  static String _sanitizeKey(dynamic key) {
    if (key == null) return '';
    if (key is String) return key.trim();
    return key.toString().trim();
  }

  // 2. Modified initialization method
  Future<void> initializeCacheInBackground() async {
    final allLessons = await _loadAllLessons();
    for (var element in allLessons) {
      log(element[kLocalFilePath].toString());
    }
    // Use static method for isolate compatibility
    final resultCache = await compute(_buildCacheIndex, allLessons);

    // Update class-level cache
    indexCache = resultCache;
    log('Index cache size: ${indexCache.length}');
  }

  // Rest of your existing methods...
}
