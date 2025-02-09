import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/entities/entitiy.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:path/path.dart' as path;

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
  void startBackgroundDownloads(List<T> items) {
    for (final item in items) {
      if (item.url == null || item.localFilePath != null) continue;
      unawaited(_downloadAndUpdateLesson(item));
    }
  }

  void startBackgroundDelete(List<T> items, DeletedItemType deletedItemType) {
    for (final item in items) {
      if (item.url == null || item.localFilePath != null) continue;
      unawaited(deleteItemFile(item: item, deletedItemType: deletedItemType));
    }
  }

  Future<void> _downloadAndUpdateLesson(T item) async {
    try {
      // Download and cache file

      final fileName = item.url!.replaceFirst('${item.versionName}/', '');
      final file = await storageService.downloadFile(
          bucketName: item.versionName, filePath: fileName);
      final localPath =
          await FileSystemCacheManager().cacheFile(item.url!, file);

      item.localFilePath = localPath;

      await updateLocalDataSource(item, PostgressEventType.insert);
      log(localPath.toString());
      // _lessonUpdatesController.add(updatedLesson);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteItemFile(
      {required T item, required DeletedItemType deletedItemType}) async {
    switch (deletedItemType) {
      case DeletedItemType.lesson:
        if (item.localFilePath != null && item.url != null) {
          final fileName = item.url!.replaceFirst('${item.versionName}/', '');
          await storageService.deleteFile(
            bucketName: item.versionName,
            fileName: fileName,
          );

          await FileSystemCacheManager()
              .deleteCachedFile(item.url!, deletedItemType);

          //await updateLocalDataSource(lesson, PostgressEventType.delete);
          // _lessonUpdatesController.add(updatedLesson);
        }
        break;
      case DeletedItemType.subject:
        final parts = path.split(item.url!);
        final fileName = parts[1];
        await storageService.deleteFolder(
          item.versionName,
          fileName,
        );

        await FileSystemCacheManager()
            .deleteCachedFile(item.url!, deletedItemType);
      default:
    }
  }
}
