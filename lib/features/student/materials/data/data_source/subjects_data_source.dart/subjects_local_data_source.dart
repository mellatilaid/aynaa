import 'dart:async';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';

import '../../../../../../core/services/background_services.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class StudentSubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final IsarStorageService isarStorageService;
  StudentSubjectsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final subjects = await isarStorageService.filter(
      collentionType: CollentionType.subjects,
      query: {kVersionID: versionID},
    );
    getit
        .get<BackgroundServices<SubjectsEntity>>()
        .startBackgroundDownloads(subjects);
    return subjects as List<SubjectsEntity>;
  }

  final _controller = StreamController<List<SubjectsEntity>>.broadcast();

  @override
  Stream<List<SubjectsEntity>> get subjectsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {SubjectsEntity? subject,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put(
            item: subject, collentionType: CollentionType.subjects);
        /* final newLessons = await isarStorageService.filter(
          collentionType: CollentionType.lessons,
          query: {
            kVersionID: lesson!.aynaaVersionId,
            kSubjectID: lesson.subjectId
          },
        ) as List<LessonEntity>;
        _controller.add(newLessons);*/
        break;
      case PostgressEventType.delete:
        await isarStorageService.delete(
            id: id!, collentionType: CollentionType.subjects);
        /*final newLessons = await isarStorageService.filter(
          collentionType: CollentionType.lessons,
          query: {
            kVersionID: lesson!.aynaaVersionId,
            kSubjectID: lesson.subjectId
          },
        ) as List<LessonEntity>;
        _controller.add(newLessons);*/
        break;
      default:
    }
  }

  void dispose() {
    _controller.close();
  }

  @override
  Future<void> deleteSubject({required String subjectID}) async {
    await isarStorageService.markAsDeleted(
      id: subjectID,
      collentionType: CollentionType.subjects,
    );
  }
}
