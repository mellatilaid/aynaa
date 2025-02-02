import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/features/admin/materials/domain/entities/lesson_entity.dart';

import '../../features/admin/materials/domain/entities/subjects_entity.dart';

dynamic propertyAccessor<T>(T item, String propertyName) {
  switch (item) {
    case SubjectsEntity():
      return item.versionID;
    case LessonEntity():
      switch (propertyName) {
        case kSubjectID:
          return item.subjectId;
        case kVersionID:
          return item.aynaaVersionId;
      }
    default:
  }
}
