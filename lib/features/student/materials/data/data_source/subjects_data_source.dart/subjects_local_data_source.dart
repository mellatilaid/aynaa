import 'dart:async';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/features/common/versions/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';

import '../../../../../../core/services/db_sync_service/db_sync_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class StudentSubjectsLocalDataSourceImpl implements SubjectsLocalDataSource {
  final ILocalDbService iLocalDbService;
  StudentSubjectsLocalDataSourceImpl({required this.iLocalDbService});
  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final subjects = await iLocalDbService.filter(
      collentionType: Entities.subjects,
      query: {kVersionID: versionID},
    );
    getit.get<DBSyncService<SubjectsEntity>>().donwloadInBauckground(subjects);
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
        await iLocalDbService.put(item: subject);
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
        await iLocalDbService.delete(id: id!);
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
    await iLocalDbService.markAsDeleted(
      id: subjectID,
      collentionType: Entities.subjects,
    );
  }
}
