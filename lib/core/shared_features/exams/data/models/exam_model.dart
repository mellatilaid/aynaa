import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';

class ExamModel extends ExamEntity with Mappable {
  ExamModel(
      {required super.uuid,
      required super.title,
      required super.image,
      required super.localFilePath});

  @override
  Map<String, dynamic> toMap() {
    return {
      kUuid: uuid,
      kName: title,
      kUrl: image,
      kLocalFilePath: localFilePath,
    };
  }

  static ExamModel fromMap(Map<String, dynamic> map) {
    return ExamModel(
      uuid: map[kUuid],
      title: map[kName],
      image: map[kUrl],
      localFilePath: map[kLocalFilePath],
    );
  }

  factory ExamModel.fromExamEntity(ExamEntity exam) {
    return ExamModel(
      uuid: exam.uuid,
      title: exam.title,
      image: exam.image,
      localFilePath: exam.localFilePath,
    );
  }
}
