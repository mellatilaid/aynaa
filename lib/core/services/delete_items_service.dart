import 'package:atm_app/core/entities/entitiy.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/file_cach_manager.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/domain/entities/deleted_itmes_entity.dart';
import 'package:path/path.dart' as path;

import '../const/remote_db_const.dart';
import '../utils/db_enpoints.dart';

abstract class DeleteItemsService<T> {
  Future<void> deleteItemPermanently(
      {required DeletedItemType deletedItemType});
  Future<void> deleteItemFromRemote();
  Future<void> deleteItemFromLocal();
  Future<void> markItemAsDeleted(
      {required Entity item, required DeletedItemType deletedItemType});
}

class DeleteItemsServiceImpl<T> extends DeleteItemsService {
  final DataBase dataBase;
  final StorageService storageService;

  final IsarStorageService isarStorageService;
  DeleteItemsServiceImpl({
    required this.dataBase,
    required this.storageService,
    required this.isarStorageService,
  });

  late Entity _item;
  late DeletedItemType _deletedItemType;
  late List<DeletedItmesEntity> deletedItems;
  @override
  Future<void> deleteItemPermanently(
      {required DeletedItemType deletedItemType}) async {
    _deletedItemType = deletedItemType;
    deletedItems = await isarStorageService.getAll(
      collentionType: CollentionType.deletedItmes,
    ) as List<DeletedItmesEntity>;
    for (var item in deletedItems) {
      _item = await isarStorageService.get(
        id: item.itemID,
        collentionType: CollentionType.subjects,
      );
      await Future.wait([
        deleteItemFromRemote(),
        deleteItemFromLocal(),
      ]);
    }
  }

  @override
  Future<void> deleteItemFromRemote() async {
    switch (_deletedItemType) {
      case DeletedItemType.subject:
        await storageService.deleteFile(
            bucketName: _item.versionName, fileName: _getFileName());
        await dataBase.deleteData(
            path: DbEnpoints.subjects, uid: _item.entityID);
        break;
      default:
    }
  }

  @override
  Future<void> deleteItemFromLocal() async {
    await getit.get<FileCacheManager>().deleteCachedFile(
          _getFileName(),
          _deletedItemType,
        );
    await _deleteRelatedItems();
  }

  _deleteRelatedItems() async {
    switch (_deletedItemType) {
      case DeletedItemType.subject:
        final relatedLessons = isarStorageService.filter(
            collentionType: CollentionType.lessons,
            query: {kSubjectID: _item.entityID});
        if (relatedLessons.isEmpty) {
          isarStorageService.delete(
              id: _item.entityID, collentionType: CollentionType.subjects);
          isarStorageService.delete(
              id: _item.entityID, collentionType: CollentionType.deletedItmes);
        } else {
          final deletedLessonsIds = relatedLessons.map((e) => e.id).toList();
          isarStorageService.deleteAll(
            ids: deletedLessonsIds,
            collentionType: CollentionType.lessons,
          );
        }
        break;
      default:
    }
  }

  _getFileName() {
    switch (_deletedItemType) {
      case DeletedItemType.subject:
        final baseName = path.basename(_item.url!);
        final fileName = _item.url!.replaceFirst(baseName, '');
        return fileName;
      default:
    }
  }

  @override
  Future<void> markItemAsDeleted(
      {required Entity item, required DeletedItemType deletedItemType}) async {
    _item = item;
    _deletedItemType = deletedItemType;
    await isarStorageService.markAsDeleted(
      id: item.entityID,
      collentionType: CollentionType.subjects,
    );
    deleteItemPermanently(deletedItemType: deletedItemType);
    /*final itemDeleted = DeletedItmesEntity(id, false, false);
    await isarStorageService.put(
      item: itemDeleted,
      collentionType: CollentionType.deletedItmes,
    );*/
    /*await isarStorageService.put(
      item: item,
      collentionType: CollentionType.deletedItmes,
    );*/
  }
}


/*import 'dart:isolate';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:injectable/injectable.dart';
import 'package:your_app/database.dart';
import 'package:your_app/storage_service.dart';
import 'package:your_app/isar_storage_service.dart';
import 'package:your_app/file_cache_manager.dart';
import 'package:your_app/entities.dart';

@Injectable(as: DeleteItemsService)
class DeleteItemsServiceImpl extends DeleteItemsService {
  final DataBase dataBase;
  final StorageService storageService;
  final IsarStorageService isarStorageService;
  final FileCacheManager cacheManager;

  DeleteItemsServiceImpl(
    this.dataBase,
    this.storageService,
    this.isarStorageService,
    this.cacheManager,
  ) {
    _startIsolate();
  }

  static SendPort? _sendPort;
  static late ReceivePort _receivePort;
  static Isolate? _isolate;

  void _startIsolate() async {
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_deleteItemsInIsolate, _receivePort.sendPort);
    _receivePort.listen((message) {
      if (message is SendPort) {
        _sendPort = message;
      }
    });
  }

  @override
  Future<void> deleteItemPermanently({required DeletedItemType deletedItemType}) async {
    if (_sendPort == null) return;
    deletedItems = await isarStorageService.getAll(
      collentionType: CollentionType.deletedItmes,
    ) as List<DeletedItmesEntity>;

    _sendPort!.send({
      'deletedItems': deletedItems.map((item) => item.itemID).toList(),
      'deletedItemType': deletedItemType.index,
    });
  }

  static Future<void> _deleteItemsInIsolate(SendPort mainSendPort) async {
    final ReceivePort isolateReceivePort = ReceivePort();
    mainSendPort.send(isolateReceivePort.sendPort);

    final DataBase dataBase = getIt<DataBase>();
    final StorageService storageService = getIt<StorageService>();
    final IsarStorageService isarStorageService = getIt<IsarStorageService>();
    final FileCacheManager cacheManager = getIt<FileCacheManager>();

    isolateReceivePort.listen((message) async {
      if (message is Map<String, dynamic>) {
        List<String> deletedItemIds = message['deletedItems'];
        int deletedItemTypeIndex = message['deletedItemType'];
        DeletedItemType deletedItemType = DeletedItemType.values[deletedItemTypeIndex];

        while (deletedItemIds.isNotEmpty) {
          String itemId = deletedItemIds.removeLast();
          Entity? item = await isarStorageService.get(
            id: itemId,
            collentionType: CollentionType.subjects,
          );

          if (item != null) {
            await Future.wait([
              _deleteItemFromRemote(item, deletedItemType, dataBase, storageService),
              _deleteItemFromLocal(item, deletedItemType, cacheManager, isarStorageService),
            ]);
          }
        }
      }
    });
  }

  static Future<void> _deleteItemFromRemote(
    Entity item,
    DeletedItemType deletedItemType,
    DataBase dataBase,
    StorageService storageService,
  ) async {
    switch (deletedItemType) {
      case DeletedItemType.subject:
        await storageService.deleteFile(
          bucketName: item.versionName,
          fileName: _getFileName(item),
        );
        await dataBase.deleteData(
          path: DbEnpoints.subjects,
          uid: item.entityID,
        );
        break;
      default:
        break;
    }
  }

  static Future<void> _deleteItemFromLocal(
    Entity item,
    DeletedItemType deletedItemType,
    FileCacheManager cacheManager,
    IsarStorageService isarStorageService,
  ) async {
    await cacheManager.deleteCachedFile(_getFileName(item));

    switch (deletedItemType) {
      case DeletedItemType.subject:
        final relatedLessons = isarStorageService.filter(
          collentionType: CollentionType.lessons,
          query: {kSubjectID: item.entityID},
        );
        if (relatedLessons.isEmpty) {
          await isarStorageService.delete(id: item.entityID, collentionType: CollentionType.subjects);
          await isarStorageService.delete(id: item.entityID, collentionType: CollentionType.deletedItmes);
        } else {
          final deletedLessonsIds = relatedLessons.map((e) => e.id).toList();
          await isarStorageService.deleteAll(ids: deletedLessonsIds, collentionType: CollentionType.lessons);
        }
        break;
      default:
        break;
    }
  }

  static String _getFileName(Entity item) {
    switch (item.deletedItemType) {
      case DeletedItemType.subject:
        final baseName = path.basename(item.url!);
        final fileName = item.url!.replaceFirst(baseName, '');
        return fileName;
      default:
        return '';
    }
  }
}
*/