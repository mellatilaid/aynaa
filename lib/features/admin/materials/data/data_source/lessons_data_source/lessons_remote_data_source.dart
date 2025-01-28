import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/enums/entities.dart';
import '../../../../../../core/functions/map_to_list_of_entity.dart';
import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/services/hive_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID});
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  final HiveCache hiveCache;
  LessonsRemoteDataSourceImpl(
      {required this.dataBase, required this.hiveCache});
  @override
  Future<List<LessonEntity>> fetchLessons(
      {required String subjectID, required String versionID}) async {
    log(subjectID);
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.lessons, query: {
      kSubjectID: subjectID,
      kVersionID: versionID,
    });

    List<LessonEntity> lessons =
        mapToListOfEntity<LessonEntity>(data, Entities.lesson);
    hiveCache.putAll(boxName: kLessonsBox, items: lessons);
    return lessons;
  }

  List<LessonEntity> convertToAynaaVersionEntity(
      List<Map<String, dynamic>> data) {
    final List<LessonEntity> lessons = data.map((item) {
      return LessonModel.fromMap(item);
    }).toList();
    return lessons;
  }
}
