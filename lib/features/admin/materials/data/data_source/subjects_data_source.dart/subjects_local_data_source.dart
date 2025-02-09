import 'dart:async';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';

import '../../../../../../core/services/background_download_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../domain/entities/subjects_entity.dart';

abstract class SubjectsLocalDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
  Future<void> deleteSubject({required String subjectID});
  Future<void> handleUpdate(
      {required SubjectsEntity subject, required PostgressEventType eventType});
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
    getit
        .get<BackgroundDownloadService<SubjectsEntity>>()
        .startBackgroundDownloads(subjects);
    return subjects as List<SubjectsEntity>;
  }

  final _controller = StreamController<List<SubjectsEntity>>.broadcast();

  @override
  Stream<List<SubjectsEntity>> get subjectsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {required SubjectsEntity subject,
      required PostgressEventType eventType}) async {
    await isarStorageService.put(
      item: subject,
      collentionType: CollentionType.subjects,
    );
  }

  void dispose() {
    _controller.close();
  }

  @override
  Future<void> deleteSubject({required String subjectID}) async {
    await isarStorageService.markAsDeleted(
        id: subjectID, collentionType: CollentionType.subjects);
  }
}
