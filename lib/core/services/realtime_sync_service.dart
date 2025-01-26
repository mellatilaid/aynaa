import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RealtimeSyncService {
  /*final DataBase _supabase;
  final HiveCache<AynaaVersionsEntity> _cache;

  RealtimeSyncService(this._supabase, this._cache);*/
  late RealtimeChannel _subscribe;
  void init() {
    _subscribe = Supabase.instance.client
        .channel('public:countries')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'aynaaVersions',
          callback: (payload) {
            log(payload.eventType.toString());
            if (payload.eventType == PostgresChangeEvent.insert) {
              final aynaaVersionsEntity = AynaaVersionsEntity(
                id: payload.newRecord[kUuid],
                versionName: payload.newRecord[kVersionName],
              );

              getit
                  .get<VersionsLocalDataSource>()
                  .handleUpdate([aynaaVersionsEntity]);
            }
          },
        )
        .subscribe();
  }

  void dispose() {
    _subscribe.unsubscribe();
    log('disposed');
  }
}
