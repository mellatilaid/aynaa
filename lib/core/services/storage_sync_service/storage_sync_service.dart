import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/services/storage_sync_service/I_storage_sync_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:path/path.dart' as path;

class StorageSyncService<T extends Entity> extends IStorageSyncService {
  final StorageService storageService;
  final FileCacheManager fileSystemCacheManager;
  final ILocalDbService iLocalDbService;
  final Future<void> Function(T entity, PostgressEventType eventType)
      updateLocalDataSource;
  StorageSyncService({
    required this.storageService,
    required this.fileSystemCacheManager,
    required this.updateLocalDataSource,
    required this.iLocalDbService,
  });

  @override
  void donwloadInBauckground(List<Entity> items,
      [CollentionType? collectionType]) {
    for (final item in items) {
      if (item.url == null || item.localFilePath != null) continue;
      unawaited(_downloadAndUpdateItem(item as T, collectionType!));
    }
  }

  @override
  void deleteInBauckground(
      List<Entity> items, DeletedItemType deletedItemType) {
    for (final item in items) {
      if (item.localFilePath != null) continue;
      unawaited(deleteItemFile(item: item, deletedItemType: deletedItemType));
    }
  }

  Future<void> _downloadAndUpdateItem(
      T item, CollentionType collectionType) async {
    try {
      // Download and cache file
      if (item.url == null) return;
      final fileName = item.url!.replaceFirst('${item.versionName}/', '');
      final file = await storageService.downloadFile(
          bucketName: item.versionName, filePath: fileName);
      final localPath = await fileSystemCacheManager.cacheFile(item.url!, file);

      item.localFilePath = localPath;

      //  await updateLocalDataSource(item, PostgressEventType.insert);
      await updateLocalDB(
          item: item,
          eventType: PostgressEventType.insert,
          collectionType: collectionType);
      log(localPath.toString());
      // _lessonUpdatesController.add(updatedLesson);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteItemFile(
      {required Entity item, required DeletedItemType deletedItemType}) async {
    switch (deletedItemType) {
      case DeletedItemType.lesson:
        if (item.localFilePath != null && item.url != null) {
          final fileName = item.url!.replaceFirst('${item.versionName}/', '');
          if (ProfileStorageImpl.userRole == kAdminRole) {
            await storageService.deleteFile(
              bucketName: item.versionName,
              fileName: fileName,
            );
          }

          await fileSystemCacheManager.deleteCachedFile(
              item.url!, deletedItemType);

          //await updateLocalDataSource(lesson, PostgressEventType.delete);
          // _lessonUpdatesController.add(updatedLesson);
        }
        break;
      case DeletedItemType.subject:
        final parts = path.split(item.url!);
        final fileName = parts[1];
        if (ProfileStorageImpl.userRole == kAdminRole) {
          await storageService.deleteFolder(
            item.versionName,
            fileName,
          );
        }

        await fileSystemCacheManager.deleteCachedFile(
            item.url!, deletedItemType);
        break;
      case DeletedItemType.version:
        if (ProfileStorageImpl.userRole == kAdminRole) {
          await storageService.deleteBucket(
            item.versionName,
          );
        }

        await fileSystemCacheManager.deleteCachedFile(
            item.url!, deletedItemType);
        await updateLocalDB(
          eventType: PostgressEventType.delete,
          id: item.entityID,
          collectionType: CollentionType.versions,
        );
    }
  }

  @override
  Future<void> updateLocalDB(
      {Entity? item,
      String? id,
      required CollentionType collectionType,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        switch (collectionType) {
          case CollentionType.versions:
            await iLocalDbService.put<AynaaVersionsEntity>(item: item);
          case CollentionType.subjects:
            await iLocalDbService.put<SubjectsEntity>(item: item);
          case CollentionType.lessons:
            await iLocalDbService.put<LessonEntity>(item: item);
          case CollentionType.exam:
            await iLocalDbService.put<ExamEntity>(item: item);
          case CollentionType.deletedItmes:
            await iLocalDbService.put<DeletedItmesEntity>(item: item);
        }
        break;
      case PostgressEventType.delete:
        switch (collectionType) {
          case CollentionType.versions:
            await iLocalDbService.delete<AynaaVersionsEntity>(id: id!);
          case CollentionType.subjects:
            await iLocalDbService.delete<SubjectsEntity>(id: id!);
          case CollentionType.lessons:
            await iLocalDbService.delete<LessonEntity>(id: id!);
          case CollentionType.exam:
            await iLocalDbService.delete<ExamEntity>(id: id!);
          case CollentionType.deletedItmes:
            await iLocalDbService.delete<DeletedItmesEntity>(id: id!);
        }
        break;
      default:
    }
  }
}
