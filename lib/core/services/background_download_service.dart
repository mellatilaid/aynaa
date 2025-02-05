import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/entities/entitiy.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/storage_service.dart';

class BackgroundDownloadService<T extends Entity> {
  final StorageService storageService;
  final FileCacheManager fileSystemCacheManager;
  final Future<void> Function(T entity, PostgressEventType eventType)
      updateLocalDataSource;
  BackgroundDownloadService({
    required this.storageService,
    required this.fileSystemCacheManager,
    required this.updateLocalDataSource,
  });
  void startBackgroundDownloads(List<T> lessons) {
    for (final lesson in lessons) {
      if (lesson.url == null || lesson.localFilePath != null) continue;
      unawaited(_downloadAndUpdateLesson(lesson));
    }
  }

  Future<void> _downloadAndUpdateLesson(T lesson) async {
    try {
      // Download and cache file

      final fileName = lesson.url!.replaceFirst('${lesson.versionName}/', '');
      final file = await storageService.downloadFile(
          bucketName: lesson.versionName, filePath: fileName);
      final localPath =
          await FileSystemCacheManager().cacheFile(fileName, file);
      log(fileName);
      lesson.localFilePath = localPath;
      await updateLocalDataSource(lesson, PostgressEventType.insert);
      // _lessonUpdatesController.add(updatedLesson);
    } catch (e) {
      log(e.toString());
    }
  }
}
