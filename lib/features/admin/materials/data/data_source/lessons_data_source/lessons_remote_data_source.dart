import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/background_download_service.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/supabase_storage.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/enums/entities.dart';
import '../../../../../../core/functions/map_to_list_of_entity.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/services/hive_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID});
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  final HiveCache hiveCache;
  LessonsRemoteDataSourceImpl(
      {required this.dataBase, required this.hiveCache});
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    log(subjectID);
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.lessons, query: {
      kSubjectID: subjectID,
      kVersionID: versionID,
    });

    List<LessonEntity> lessons =
        mapToListOfEntity<LessonEntity>(data, Entities.lesson);

    hiveCache.putAll(boxName: kLessonsBox, items: lessons);
    BackgroundDownloadService(
      fileSystemCacheManager: FileSystemCacheManager(),
      storageService: SupaBaseStorage(),
      updateLocalDataSource: (LessonEntity entity) =>
          getit.get<LessonsLocalDataSource>().handleUpdate(
                lesson: entity,
              ),
    ).startBackgroundDownloads(lessons);
    //_startBackgroundDownloads(lessons);
    return lessons;
  }

  void _startBackgroundDownloads(List<LessonEntity> lessons) {
    for (final lesson in lessons) {
      if (lesson.url == null || lesson.localFilePath != null) continue;
      unawaited(_downloadAndUpdateLesson(lesson));
    }
  }

  Future<void> _downloadAndUpdateLesson(LessonEntity lesson) async {
    try {
      // Download and cache file
      final fileName = lesson.url!.replaceFirst('${lesson.versionName}/', '');
      final file = await SupaBaseStorage()
          .downloadFile(bucketName: lesson.versionName, filePath: fileName);
      final localPath =
          await FileSystemCacheManager().cacheFile(fileName, file);
      log(fileName);
      lesson.localFilePath = localPath;
      await getit.get<LessonsLocalDataSource>().handleUpdate(lesson: lesson);
      // _lessonUpdatesController.add(updatedLesson);
    } catch (e) {}
  }
}


/*final cachingFutures = lessons.map((lesson) async {
      if (lesson.url == null) return;

      final fileName = lesson.url!.replaceFirst('${lesson.versionName}/', '');
      /*final cachedPath = await FileSystemCacheManager().getCachedPath(fileName);
    
    // Return early if already cached
    if (cachedPath != null) {
      lesson.localFilePath = cachedPath;
      return;
    }*/

      final file = await SupaBaseStorage()
          .downloadFile(bucketName: lesson.versionName, filePath: fileName);
      final localPath =
          await FileSystemCacheManager().cacheFile(fileName, file);
      lesson.localFilePath = localPath;
    }).toList();

    // Wait for all downloads to complete before caching lessons
    await Future.wait(cachingFutures);*/