import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';

import '../../../../../const.dart';
import '../../../../../core/mixins/mappable.dart';

class LessonModel extends LessonEntity with Mappable {
  LessonModel(super.id, super.name, super.url, super.description,
      super.aynaaVersionId, super.subjectId);

  @override
  toMap() {
    return {
      kUuid: id,
      kName: name,
      kUrl: url,
      kDesc: description,
      kVersionID: aynaaVersionId,
      kSubjectID: subjectId,
    };
  }

  static LessonModel fromMap(Map<String, dynamic> map) {
    return LessonModel(
      map[kUuid],
      map[kName],
      map[kUrl],
      map[kDesc],
      map[kVersionID],
      map[kSubjectID],
    );
  }
}
