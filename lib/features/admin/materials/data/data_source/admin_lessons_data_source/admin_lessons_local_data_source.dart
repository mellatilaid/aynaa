import 'dart:async';

import 'package:atm_app/core/common/entitiy.dart';
import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';

import '../../../../../../core/materials/domain/entities/lesson_entity.dart';
import '../../../../../../core/services/storage_sync_service/storage_sync_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class AdminLessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final ILocalDbService iLocalDbService;
  AdminLessonsLocalDataSourceImpl({required this.iLocalDbService});
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID}) async {
    final lessons = await iLocalDbService.filter(
      collentionType: CollentionType.lessons,
      query: {kVersionID: versionID, kSubjectID: subjectID},
    ) as List<LessonEntity>;

    getit
        .get<StorageSyncService<LessonEntity>>()
        .donwloadInBauckground(lessons);
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
