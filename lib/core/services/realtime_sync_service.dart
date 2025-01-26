import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';
import 'package:atm_app/features/admin/materials/data/models/subjects_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/admin/materials/data/data_source/subjects_data_source.dart/subjects_local_data_source.dart';

/*class RealtimeSyncService {
  /*final DataBase _supabase;
  final HiveCache<AynaaVersionsEntity> _cache;

  RealtimeSyncService(this._supabase, this._cache);*/
  late RealtimeChannel _subscribe;
  final List<RealtimeChannel> _subscriptions = [];
  final Map<String, Function(dynamic)> _tableHandlers = {};

  void init() {
    _subscribe = Supabase.instance.client
        .channel('public:countries')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: kVersionsBox,
          callback: (payload) {
            log(payload.eventType.toString());
            if (payload.eventType == PostgresChangeEvent.insert) {
              final aynaaVersionsEntity = AynaaVersionsEntity(
                id: payload.newRecord[kUuid],
                versionName: payload.newRecord[kVersionName],
              );

              getit.get<VersionsLocalDataSource>().handleUpdate(
                [aynaaVersionsEntity],
              );
            }
          },
        )
        .subscribe();
  }

  void dispose() {
    _subscribe.unsubscribe();
    log('disposed');
  }
}*/

class RealtimeSyncService {
  final List<RealtimeChannel> _subscriptions = [];
  final Map<String, Function(PostgresChangePayload)> _tableHandlers = {};

  void initialize() {
    // Add multiple table subscriptions
    _subscribeToTable(
      table: kVersionsBox,
      handler: _handleVersionChange,
    );

    _subscribeToTable(
      table: kSubjectsBox,
      handler: _handleSubjectChange,
    );

    _subscribeToTable(
      table: kLessonsBox,
      handler: _handleLessonChange,
    );
  }

  void _subscribeToTable({
    required String table,
    required Function(PostgresChangePayload payload) handler,
  }) {
    final channel = Supabase.instance.client
        .channel('public:$table')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: table,
          callback: handler,
        )
        .subscribe();

    _subscriptions.add(channel);
    _tableHandlers[table] = handler;
  }

  void _handleVersionChange(PostgresChangePayload payload) {
    if (payload.eventType == PostgresChangeEvent.insert) {
      final entity = AynaaVersionsModel.fromMap(payload.newRecord);
      getit.get<VersionsLocalDataSource>().handleUpdate([entity]);
    }
    // Add update/delete handling
  }

  void _handleSubjectChange(PostgresChangePayload payload) {
    if (payload.eventType == PostgresChangeEvent.insert) {
      final entity = SubjectsModel.fromMap(payload.newRecord);
      getit.get<SubjectsLocalDataSource>().handleUpdate([entity]);
    }
  }

  void _handleLessonChange(PostgresChangePayload payload) {
    if (payload.eventType == PostgresChangeEvent.insert) {
      final entity = LessonModel.fromMap(payload.newRecord);
      //getit.get<LessonsLocalDataSource>().handleUpdate([entity]);
    }
  }

  void dispose() {
    for (final sub in _subscriptions) {
      sub.unsubscribe();
    }
    _subscriptions.clear();
    _tableHandlers.clear();
    log('All realtime subscriptions disposed');
  }
}
