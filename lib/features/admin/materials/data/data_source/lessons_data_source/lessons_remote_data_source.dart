import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';

import '../../../../../../core/services/data_base.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../domain/entities/lesson_entity.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonEntity>> fetchLessons({required String subjectID});
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  final DataBase dataBase;
  LessonsRemoteDataSourceImpl({required this.dataBase});
  @override
  Future<List<LessonEntity>> fetchLessons({required String subjectID}) async {
    final List<Map<String, dynamic>> aynaaVersions =
        await dataBase.getDate(path: DbEnpoints.lessons);

    List<LessonEntity> lessons = convertToAynaaVersionEntity(aynaaVersions);

    return lessons;
  }

  List<LessonEntity> convertToAynaaVersionEntity(
      List<Map<String, dynamic>> versions) {
    final List<LessonEntity> aynaaVersions = versions.map((item) {
      return LessonModel.fromMap(item);
    }).toList();
    return aynaaVersions;
  }
}
