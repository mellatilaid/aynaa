import 'dart:async';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';

import '../../../../../../core/materials/domain/entities/lesson_entity.dart';
import '../../../../../../core/services/background_services.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class StudentLessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final LocalDBService isarStorageService;
  StudentLessonsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID}) async {
    final lessons = await isarStorageService.filter(
      collentionType: CollentionType.lessons,
      query: {kVersionID: versionID, kSubjectID: subjectID},
    ) as List<LessonEntity>;

    getit
        .get<BackgroundServices<LessonEntity>>()
        .startBackgroundDownloads(lessons);
    return lessons;
  }

  final _controller = StreamController<List<LessonEntity>>.broadcast();

  @override
  Stream<List<LessonEntity>> get lessonsStream => _controller.stream;

  @override
  Future<void> handleUpdate(
      {required PostgressEventType eventType,
      LessonEntity? lesson,
      String? id}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put(item: lesson);
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
            id: id!, collentionType: CollentionType.lessons);
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
