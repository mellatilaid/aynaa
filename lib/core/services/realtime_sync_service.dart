import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/core/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/core/materials/data/models/lesson_model.dart';
import 'package:atm_app/core/materials/data/models/subjects_model.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/background_services.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      table: DbEnpoints.aynaaVersions,
      handler: _handleVersionChange,
    );

    _subscribeToTable(
      table: DbEnpoints.subjects,
      handler: _handleSubjectChange,
    );

    _subscribeToTable(
      table: DbEnpoints.lessons,
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
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
        final entity = AynaaVersionsModel.fromMap(payload.newRecord);
        log(payload.toString());
        log('iserted subject to remote id is ${entity.entityID}');
        getit.get<VersionsLocalDataSource>().handleUpdate(
            version: entity, eventType: PostgressEventType.insert);
        getit
            .get<BackgroundServices<AynaaVersionsEntity>>()
            .startBackgroundDownloads([entity]);
        break;
      case PostgresChangeEvent.delete:
        getit.get<VersionsLocalDataSource>().handleUpdate(
              id: payload.oldRecord[kUuid],
              eventType: PostgressEventType.delete,
            );
        break;
      default:
    }

    // Add update/delete handling
  }

  void _handleSubjectChange(PostgresChangePayload payload) {
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
        final entity = SubjectsModel.fromMap(payload.newRecord);
        log(payload.toString());
        log('iserted subject to remote id is ${entity.entityID}');
        getit.get<SubjectsLocalDataSource>().handleUpdate(
            subject: entity, eventType: PostgressEventType.insert);
        getit
            .get<BackgroundServices<SubjectsEntity>>()
            .startBackgroundDownloads([entity]);
        break;
      case PostgresChangeEvent.delete:
        getit.get<SubjectsLocalDataSource>().handleUpdate(
              id: payload.oldRecord[kUuid],
              eventType: PostgressEventType.delete,
            );
        break;
      default:
    }
  }

  void _handleLessonChange(PostgresChangePayload payload) {
    log(payload.toString());
    switch (payload.eventType) {
      case PostgresChangeEvent.insert:
        final entity = LessonModel.fromMap(payload.newRecord);
        log(payload.toString());
        getit
            .get<LessonsLocalDataSource>()
            .handleUpdate(lesson: entity, eventType: PostgressEventType.insert);
        getit
            .get<BackgroundServices<LessonEntity>>()
            .startBackgroundDownloads([entity]);
        break;
      case PostgresChangeEvent.delete:
        getit.get<LessonsLocalDataSource>().handleUpdate(
              id: payload.oldRecord[kUuid],
              eventType: PostgressEventType.delete,
            );

        break;
      default:
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
