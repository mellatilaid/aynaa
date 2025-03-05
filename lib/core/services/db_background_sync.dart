import 'dart:async';
import 'dart:isolate';

import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsolateSyncParams {
  final String isarPath;
  final String tableName;
  final Future<List<Map<String, dynamic>>> Function() fetchRemoteData;
  final Future<List<Map<String, dynamic>>> Function() fetchAllIds;
  final Function(Map<String, dynamic>) fromJson;

  IsolateSyncParams({
    required this.isarPath,
    required this.tableName,
    required this.fetchRemoteData,
    required this.fetchAllIds,
    required this.fromJson,
  });
}

Future<void> syncDataInBackground(IsolateSyncParams params) async {
  final dir = await getApplicationDocumentsDirectory();
  final isarPath = dir.path;

  /*final params = IsolateSyncParams(
    isarPath: isarPath,
    tableName: 'subjects',
    fetchRemoteData: () async =>
        await supabase.getData(path: DbEnpoints.aynaaVersions),
    fetchAllIds: () async =>
        await supabase.getData(path: DbEnpoints.aynaaVersions, columns: kUuid),
    fromJson: (json) => AynaaVersionsModel.fromJson(json),
  );*/

  await Isolate.spawn(_syncIsolate, '');
}

void _syncIsolate(String params) async {
  // final IsarStorageService isar0 = IsarStorageService();
  final isar = await Isar.open(
    [AynaaVersionsEntitySchema], // Replace with your schemas
    directory: params,
  );
  BackgroundIsolateBinaryMessenger.ensureInitialized;
  //final String isarPath = await isar0.getIsarPath();
  // log(isarPath);
  //final lastSyncTime = await getLastSyncTime(isar, params.tableName);

  /*final updatedResponse = await params.fetchRemoteData();
  final allIdsResponse = await params.fetchAllIds();

  if (updatedResponse.isNotEmpty && allIdsResponse.isNotEmpty) {
    final updatedItems =
        updatedResponse.map((e) => params.fromJson(e)).toList();
    final remoteIds = allIdsResponse.map((e) => e['id'] as int).toSet();

    final localItems = await isar.aynaaVersionsEntitys.where().findAll();
    final localIds = localItems.map((e) => e.id).toSet();

    final itemsToDelete = localIds.difference(remoteIds);

    await isar.writeTxn(() async {
      await isar.aynaaVersionsEntitys
          .putAll(updatedItems as List<AynaaVersionsEntity>);
      await isar.aynaaVersionsEntitys.deleteAll(itemsToDelete.toList());
    });

    // await saveLastSyncTime(isar, params.tableName, DateTime.now());
  }*/

  isar.close();
}
