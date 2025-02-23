import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/helper/enums.dart';

abstract class IDBSyncService<T extends Entity> {
  void syncDB<E>({
    required String path,
    required Entities entityType,
    required String lastTimeItemsFetched,
  });
  void donwloadInBauckground(List<T> items, Entities collectionType);
  void deleteInBauckground(List<T> items, Entities deletedItemType);
  void updateLocalDB({
    T? item,
    String? id,
    required Entities collectionType,
    required PostgressEventType eventType,
  });
}
