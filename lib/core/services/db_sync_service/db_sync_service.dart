import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/functions/update_last_fetched_items_time.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/services/local_storage_service/i_local_storage_service.dart';
import 'package:atm_app/core/services/profile_storage.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:path/path.dart' as path;

class DBSyncService<T extends Entity> extends IDBSyncService {
  final StorageService storageService;
  final ILocalStorageService localStorageService;
  final ILocalDbService iLocalDbService;
  final DataBase dataBase;
  final Future<void> Function(T entity, PostgressEventType eventType)
      updateLocalDataSource;
  DBSyncService({
    required this.storageService,
    required this.localStorageService,
    required this.updateLocalDataSource,
    required this.iLocalDbService,
    required this.dataBase,
  });

  @override
  void donwloadInBauckground(List<Entity> items, [Entities? collectionType]) {
    for (final item in items) {
      if (item.url == null || item.localFilePath != null) continue;
      unawaited(_downloadAndUpdateItem(item as T, collectionType!));
    }
  }

  @override
  void deleteInBauckground(List<Entity> items, Entities deletedItemType) {
    for (final item in items) {
      if (item.localFilePath != null) continue;
      unawaited(deleteItemFile(item: item, deletedItemType: deletedItemType));
    }
  }

  Future<void> _downloadAndUpdateItem(T item, Entities collectionType) async {
    try {
      // Download and cache file
      if (item.url == null) return;
      final fileName = item.url!.replaceFirst('${item.versionName}/', '');
      final file = await storageService.downloadFile(
          bucketName: item.versionName, filePath: fileName);
      final localPath = await localStorageService.cacheFile(item.url!, file);

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
      {required Entity item, required Entities deletedItemType}) async {
    switch (deletedItemType) {
      case Entities.lessons:
        if (item.localFilePath != null && item.url != null) {
          final fileName = item.url!.replaceFirst('${item.versionName}/', '');
          if (ProfileStorageImpl.userRole == kAdminRole) {
            await storageService.deleteFile(
              bucketName: item.versionName,
              fileName: fileName,
            );
          }

          await localStorageService.deleteCachedFile(
              item.url!, deletedItemType);

          //await updateLocalDataSource(lesson, PostgressEventType.delete);
          // _lessonUpdatesController.add(updatedLesson);
        }
        break;
      case Entities.subjects:
        final parts = path.split(item.url!);
        final fileName = parts[1];
        if (ProfileStorageImpl.userRole == kAdminRole) {
          await storageService.deleteFolder(
            item.versionName,
            fileName,
          );
        }

        await localStorageService.deleteCachedFile(item.url!, deletedItemType);
        break;
      case Entities.versions:
        if (ProfileStorageImpl.userRole == kAdminRole) {
          if (item.isDeleted == false) {
            await storageService.deleteBucket(
              item.versionName,
            );
          }
        }

        await localStorageService.deleteCachedFile(item.url!, deletedItemType);
        await updateLocalDB(
          eventType: PostgressEventType.delete,
          id: item.entityID,
          collectionType: Entities.versions,
        );

        break;
      case Entities.exam:
      case Entities.questions:
      case Entities.examSections:
    }
  }

  @override
  Future<void> updateLocalDB(
      {Entity? item,
      String? id,
      required Entities collectionType,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        switch (collectionType) {
          case Entities.versions:
            await iLocalDbService.put<AynaaVersionsEntity>(item: item);
          case Entities.subjects:
            await iLocalDbService.put<SubjectsEntity>(item: item);
          case Entities.lessons:
            await iLocalDbService.put<LessonEntity>(item: item);
          case Entities.exam:
            await iLocalDbService.put<ExamEntity>(item: item);
          case Entities.questions:
          case Entities.examSections:
        }
        break;
      case PostgressEventType.delete:
        switch (collectionType) {
          case Entities.versions:
            await iLocalDbService.delete<AynaaVersionsEntity>(id: id!);
          case Entities.subjects:
            await iLocalDbService.delete<SubjectsEntity>(id: id!);
          case Entities.lessons:
            await iLocalDbService.delete<LessonEntity>(id: id!);
          case Entities.exam:
            await iLocalDbService.delete<ExamEntity>(id: id!);
          case Entities.questions:
          case Entities.examSections:
        }
        break;
      default:
    }
  }

  @override
  void syncDB<E>(
      {required String path,
      required Entities entityType,
      required String lastTimeItemsFetched}) async {
    List<AynaaVersionsEntity> items;

    final List<Map<String, dynamic>> updatedData = await dataBase.getData(
      path: path.toString(),
      filterComparison: FilterComparison.greaterThan,
      query: {kUpdatedAt: lastTimeItemsFetched},
    );
    final List<Map<String, dynamic>> deletedItems = await dataBase.getData(
      path: path.toString(),
      filterComparison: FilterComparison.equal,
      query: {kIsDeleted: true},
    );

    if (updatedData.isNotEmpty) {
      items = mapToListOfEntity(updatedData, entityType);
      //update last time versions fetched from remote in settings
      updateLastFetchedItemsTime(itemType: entityType);

      iLocalDbService.putAll<E>(
        items: items,
        collentionType: entityType,
      );
      donwloadInBauckground(items, entityType);
    }
    if (deletedItems.isNotEmpty) {
      items = mapToListOfEntity(deletedItems, entityType);
      deleteInBauckground(items, entityType);
    }
  }
}
