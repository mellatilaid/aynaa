import 'package:atm_app/features/admin/materials/data/models/lesson_model.dart';

import '../../../../../../const.dart';
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
    final List<Map<String, dynamic>> data = await dataBase
        .getDate(path: DbEnpoints.lessons, query: {kSubjectID: subjectID});

    List<LessonEntity> lessons = convertToAynaaVersionEntity(data);

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
