import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity with Mappable {
  QuestionModel({
    required super.entityID,
    required super.sectionID,
    required super.question,
    required super.answer,
    required super.options,
    required super.updatedAt,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      kSectionID: sectionID,
      kQuestion: question,
      kAnswer: answer,
      kOptions: options,
      kUpdatedAt: updatedAt,
    };
  }

  static QuestionModel fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      entityID: map[kUuid],
      sectionID: map[kSectionID],
      question: map[kQuestion],
      answer: map[kAnswer],
      options: List<String>.from(map[kOptions]),
      updatedAt: map[kUpdatedAt],
    );
  }

  factory QuestionModel.fromEntity(QuestionEntity question) {
    return QuestionModel(
      entityID: question.entityID,
      sectionID: question.sectionID,
      question: question.question,
      answer: question.answer,
      options: question.options,
      updatedAt: question.updatedAt,
    );
  }
}
