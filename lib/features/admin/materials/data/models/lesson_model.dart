import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';

import '../../../../../const.dart';
import '../../../../../core/mixins/mappable.dart';

class LessonModel extends LessonEntity with Mappable {
  LessonModel(
    String? id,
    String? name,
    String? url,
    String? description,
    String aynaaVersionId,
    String subjectId,
  ) : super(
          id: id,
          name: name,
          url: url,
          description: description,
          aynaaVersionId: aynaaVersionId,
          subjectId: subjectId,
        );

  @override
  toMap() {
    return {
      kName: name,
      kUrl: url,
      kContent: description,
      kVersionID: aynaaVersionId,
      kSubjectID: subjectId,
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
    );
  }
}
