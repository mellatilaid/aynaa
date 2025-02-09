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
  Future<void> markItemAsDeleted({required DeletedItmesEntity item});
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
    await getit.get<FileCacheManager>().deleteCachedFile(_getFileName());
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
        } else {
          isarStorageService.delete(
              id: _item.entityID, collentionType: CollentionType.lessons);
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
  Future<void> markItemAsDeleted({required DeletedItmesEntity item}) async {
    await isarStorageService.markAsDeleted(
      id: item.itemID,
      collentionType: CollentionType.subjects,
    );
    await isarStorageService.put(
      item: item,
      collentionType: CollentionType.deletedItmes,
    );
  }
}
