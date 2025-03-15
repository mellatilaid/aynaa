import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity with Mappable {
  ExamModel(
      {required super.entityID,
      required super.title,
      required super.versionName,
      required super.versionID,
      required super.url,
      required super.updatedAt,
      super.localFilePath});

  @override
  Map<String, dynamic> toMap() {
    return {
      kTitle: title,
      kUrl: url,
      kVersionID: versionID,
      kVersionName: versionName,
      kUpdatedAt: updatedAt,
    };
  }

  static ExamModel fromMap(Map<String, dynamic> map) {
    return ExamModel(
      entityID: map[kUuid],
      title: map[kTitle],
      versionID: map[kVersionID],
      versionName: map[kVersionName],
      url: map[kUrl],
      updatedAt: map[kUpdatedAt],
    );
  }

  factory ExamModel.fromExamEntity(ExamEntity exam) {
    return ExamModel(
      entityID: exam.entityID,
      title: exam.title,
      versionID: exam.versionID,
      versionName: exam.versionName,
      url: exam.url,
      localFilePath: exam.localFilePath,
      updatedAt: exam.updatedAt,
    );
  }
}
