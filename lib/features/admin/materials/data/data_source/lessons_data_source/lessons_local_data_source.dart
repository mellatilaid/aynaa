import 'dart:async';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/services/hive_service.dart';

import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsLocalDataSource {
  Future<List<LessonEntity>> fetchLessons();
  Future<void> handleUpdate(List<LessonEntity> versions);
  Stream<List<LessonEntity>> get lessonsStream;
}

class LessonsLocalDataSourceImpl implements LessonsLocalDataSource {
  final HiveCache hiveCache;
  LessonsLocalDataSourceImpl({required this.hiveCache});
  @override
  Future<List<LessonEntity>> fetchLessons() async {
    final lessons = await hiveCache.getAll(boxName: kLessonsBox);
    return lessons as List<LessonEntity>;
  }

  final _controller = StreamController<List<LessonEntity>>.broadcast();

  @override
  Stream<List<LessonEntity>> get lessonsStream => _controller.stream;

  @override
  Future<void> handleUpdate(List<LessonEntity> lessons) async {
    await hiveCache.add(boxName: kLessonsBox, items: lessons);
    final newLessons =
        await hiveCache.getAll(boxName: kLessonsBox) as List<LessonEntity>;
    _controller.add(newLessons);
  }

  void dispose() {
    _controller.close();
  }
}
