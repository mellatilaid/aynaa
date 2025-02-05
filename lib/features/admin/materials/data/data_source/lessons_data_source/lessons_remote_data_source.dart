import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/services/background_download_service.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/functions/map_to_list_of_entity.dart';
import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID});
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  final IsarStorageService isarStorageService;
  final StorageService storageService;
  final FileCacheManager fileCacheManager;
  LessonsRemoteDataSourceImpl({
    required this.dataBase,
    required this.isarStorageService,
    required this.storageService,
    required this.fileCacheManager,
  });
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

    isarStorageService.putAll(
      items: lessons,
      collentionType: CollentionType.lessons,
    );
    getit
        .get<BackgroundDownloadService<LessonEntity>>()
        .startBackgroundDownloads(lessons);

    return lessons;
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