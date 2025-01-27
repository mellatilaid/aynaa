import 'dart:async';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/services/hive_service.dart';

import '../../../domain/entities/subjects_entity.dart';

abstract class SubjectsLocalDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> handleUpdate(
      {required SubjectsEntity subject, required String versionID});
  Stream<List<SubjectsEntity>> get subjectsStream;
}

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final HiveCache hiveCache;
  SubjectsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final subjects = await hiveCache
        .getAll(boxName: kSubjectsBox, query: {kVersionID: versionID});
    return subjects as List<SubjectsEntity>;
  }

  final _controller = StreamController<List<SubjectsEntity>>.broadcast();

  @override
  Stream<List<SubjectsEntity>> get subjectsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {required SubjectsEntity subject, required String versionID}) async {
    await hiveCache.put(
      boxName: kSubjectsBox,
      item: subject,
      id: subject.id!,
    );
    final newVersions = await hiveCache.getAll(
        boxName: kSubjectsBox,
        query: {kVersionID: versionID}) as List<SubjectsEntity>;
    _controller.add(newVersions);
  }

  void dispose() {
    _controller.close();
  }
}
