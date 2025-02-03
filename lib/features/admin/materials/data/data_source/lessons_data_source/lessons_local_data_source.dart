import 'dart:async';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/local_storage_service.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/services/background_download_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID});
  Future<void> handleUpdate({required LessonEntity lesson});
  Stream<List<LessonEntity>> get lessonsStream;
}

class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final LocalCacheService hiveCache;
  LessonsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String versionID, required String subjectID}) async {
    final lessons = await hiveCache.getAll(
      boxName: kLessonsBox,
      query: {kVersionID: versionID, kSubjectID: subjectID},
    ) as List<LessonEntity>;
    getit
        .get<BackgroundDownloadService<LessonEntity>>()
        .startBackgroundDownloads(lessons);
    return lessons;
  }

  final _controller = StreamController<List<LessonEntity>>.broadcast();

  @override
  Stream<List<LessonEntity>> get lessonsStream => _controller.stream;

  @override
  Future<void> handleUpdate({required LessonEntity lesson}) async {
    await hiveCache.put(
        boxName: kLessonsBox, item: lesson, id: lesson.entityID);
    final newLessons =
        await hiveCache.getAll(boxName: kLessonsBox) as List<LessonEntity>;
    _controller.add(newLessons);
  }

  void dispose() {
    _controller.close();
  }
}
