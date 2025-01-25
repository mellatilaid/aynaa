import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';

import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/mixins/mappable.dart';

class LessonModel extends LessonEntity with Mappable {
  LessonModel(
    String? id,
    String? name,
    String? url,
    String? description,
    String aynaaVersionId,
    String subjectId,
    String versionName,
    String subjectName,
  ) : super(
          id: id,
          name: name,
          url: url,
          description: description,
          aynaaVersionId: aynaaVersionId,
          subjectId: subjectId,
          versionName: versionName,
          subjectName: subjectName,
        );

  @override
  toMap() {
    return {
      kName: name,
      kUrl: url,
      kContent: description,
      kVersionID: aynaaVersionId,
      kSubjectID: subjectId,
      kVersionName: versionName,
      kSubjectName: subjectName,
    };
  }

  static LessonModel fromMap(Map<String, dynamic> map) {
    return LessonModel(
      map[kUuid],
      map[kName],
      map[kUrl],
      map[kContent],
      map[kVersionID],
      map[kSubjectID],
      map[kVersionName],
      map[kSubjectName],
    );
  }

  factory LessonModel.fromLessonEntity(LessonEntity lesson) {
    return LessonModel(
      lesson.id,
      lesson.name,
      lesson.url,
      lesson.description,
      lesson.aynaaVersionId,
      lesson.subjectId,
      lesson.versionName,
      lesson.subjectName,
    );
  }
}
