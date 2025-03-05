import 'package:atm_app/features/common/versions/domain/entities/lesson_entity.dart';

import '../../../../../../../core/const/remote_db_const.dart';
import '../../../../../../../core/mixins/mappable.dart';

class LessonModel extends LessonEntity with Mappable {
  LessonModel({
    required super.entityID,
    required super.name,
    super.url,
    required super.description,
    required super.aynaaVersionId,
    required super.subjectId,
    required super.versionName,
    required super.subjectName,
    required super.updatedAt,
    super.isDeleted = false,
    super.localFilePath,
    super.oldUrl,
  });
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
      kUpdatedAt: updatedAt,
    };
  }

  static LessonModel fromMap(Map<String, dynamic> map) {
    return LessonModel(
      entityID: map[kUuid],
      name: map[kName],
      url: map[kUrl],
      description: map[kContent],
      aynaaVersionId: map[kVersionID],
      subjectId: map[kSubjectID],
      versionName: map[kVersionName],
      subjectName: map[kSubjectName],
      localFilePath: map[kLocalFilePath],
      updatedAt: map[kUpdatedAt],
    );
  }

  factory LessonModel.fromLessonEntity(LessonEntity lesson) {
    return LessonModel(
      entityID: lesson.entityID,
      name: lesson.name,
      url: lesson.url,
      description: lesson.description,
      aynaaVersionId: lesson.aynaaVersionId,
      subjectId: lesson.subjectId,
      versionName: lesson.versionName,
      subjectName: lesson.subjectName,
      localFilePath: lesson.localFilePath,
      updatedAt: lesson.updatedAt,
    );
  }
}
