import 'dart:async';

import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';

import '../../../../../../core/materials/domain/entities/lesson_entity.dart';

class AdminLessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final ILocalDbService iLocalDbService;
  final IDBSyncService idbSyncService;
  AdminLessonsLocalDataSourceImpl({
    required this.iLocalDbService,
    required this.idbSyncService,
  });
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID}) async {
    final lessons = await iLocalDbService.filter(
      collentionType: Entities.lessons,
      query: {kVersionID: versionID, kSubjectID: subjectID},
    ) as List<LessonEntity>;
    idbSyncService.donwloadInBauckground(lessons, Entities.lessons);

    return lessons;
  }

  final _controller = StreamController<List<LessonEntity>>.broadcast();

  @override
  Stream<List<LessonEntity>> get lessonsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {required PostgressEventType eventType,
      Entity? lesson,
      String? id}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await iLocalDbService.put<LessonEntity>(item: lesson);
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
        await iLocalDbService.delete<LessonEntity>(id: id!);
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
}
