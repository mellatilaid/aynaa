import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/helper/enums.dart';

abstract class IStorageSyncService<T extends Entity> {
  void donwloadInBauckground(List<T> items, [CollentionType? collectionType]);
  void deleteInBauckground(List<T> items, DeletedItemType deletedItemType);
  void updateLocalDB({
    T? item,
    String? id,
    required CollentionType collectionType,
    required PostgressEventType eventType,
  });
}
