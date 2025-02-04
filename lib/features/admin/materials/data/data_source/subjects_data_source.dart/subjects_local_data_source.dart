import 'dart:async';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/enums/entities.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';

import '../../../domain/entities/subjects_entity.dart';

abstract class SubjectsLocalDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> handleUpdate(
      {required SubjectsEntity subject, required String versionID});
  Stream<List<SubjectsEntity>> get subjectsStream;
}

class SubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final IsarStorageService isarStorageService;
  SubjectsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final subjects = await isarStorageService.filter(
      collentionType: CollentionType.subjects,
      query: {kVersionID: versionID},
    );
    return subjects as List<SubjectsEntity>;
  }

  final _controller = StreamController<List<SubjectsEntity>>.broadcast();

  @override
  Stream<List<SubjectsEntity>> get subjectsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {required SubjectsEntity subject, required String versionID}) async {
    await isarStorageService.put(
      item: subject,
      collentionType: CollentionType.subjects,
    );
    final subjects = await isarStorageService.filter(
      collentionType: CollentionType.subjects,
      query: {kVersionID: subject.versionID},
    );
    _controller.add(subjects as List<SubjectsEntity>);
  }

  void dispose() {
    _controller.close();
  }
}
