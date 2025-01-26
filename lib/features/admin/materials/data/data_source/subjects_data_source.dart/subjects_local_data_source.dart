import 'dart:async';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/hive_service.dart';

import '../../../domain/entities/subjects_entity.dart';

abstract class SubjectsLocalDataSource {
  Future<List<SubjectsEntity>> fetchSubjects();
  Future<void> handleUpdate(List<SubjectsEntity> versions);
  Stream<List<SubjectsEntity>> get subjectsStream;
}

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final HiveCache hiveCache;
  SubjectsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<SubjectsEntity>> fetchSubjects() async {
    final subjects = await hiveCache.getAll(boxName: kSubjectsBox);
    return subjects as List<SubjectsEntity>;
  }

  final _controller = StreamController<List<SubjectsEntity>>.broadcast();

  @override
  Stream<List<SubjectsEntity>> get subjectsStream => _controller.stream;

  @override
  Future<void> handleUpdate(List<SubjectsEntity> subjects) async {
    await hiveCache.add(boxName: kVersionsBox, items: subjects);
    final newVersions =
        await hiveCache.getAll(boxName: kVersionsBox) as List<SubjectsEntity>;
    _controller.add(newVersions);
  }

  void dispose() {
    _controller.close();
  }
}
