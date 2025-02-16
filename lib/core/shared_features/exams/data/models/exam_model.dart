import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity with Mappable {
  ExamModel(
      {required super.entityID,
      required super.title,
      required super.versionName,
      required super.url,
      required super.localFilePath});

  @override
  Map<String, dynamic> toMap() {
    return {
      kTitle: title,
      kUrl: url,
    };
  }

  static ExamModel fromMap(Map<String, dynamic> map) {
    return ExamModel(
      entityID: map[kUuid],
      title: map[kName],
      versionName: map[kVersionName],
      url: map[kUrl],
      localFilePath: map[kLocalFilePath],
    );
  }

  factory ExamModel.fromExamEntity(ExamEntity exam) {
    return ExamModel(
      entityID: exam.entityID,
      title: exam.title,
      versionName: exam.versionName,
      url: exam.url,
      localFilePath: exam.localFilePath,
    );
  }
}
