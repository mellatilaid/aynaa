import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';

class ExamSectionsModel extends ExamSectionsEntity with Mappable {
  ExamSectionsModel({
    required super.entityID,
    required super.title,
    required super.examID,
    required super.url,
    required super.examTitle,
    required super.versionName,
    required super.updatedAt,
    super.localFilePath,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      kTitle: title,
      kUrl: url,
      kExamID: examID,
      kVersionName: versionName,
      kExamTitle: examTitle,
      kUpdatedAt: updatedAt,
    };
  }

  static ExamSectionsModel fromMap(Map<String, dynamic> map) {
    return ExamSectionsModel(
      entityID: map[kUuid],
      title: map[kTitle],
      examID: map[kExamID],
      url: map[kUrl],
      examTitle: map[kExamTitle],
      versionName: map[kVersionName],
      updatedAt: map[kUpdatedAt],
    );
  }

  factory ExamSectionsModel.fromEntity(ExamSectionsEntity exam) {
    return ExamSectionsModel(
      entityID: exam.entityID,
      title: exam.title,
      examID: exam.examID,
      examTitle: exam.examTitle,
      versionName: exam.versionName,
      url: exam.url,
      localFilePath: exam.localFilePath,
      updatedAt: exam.updatedAt,
    );
  }
}
