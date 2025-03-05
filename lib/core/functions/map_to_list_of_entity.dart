import 'package:atm_app/features/common/exams/data/models/exam_model.dart';
import 'package:atm_app/features/common/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/features/common/exams/data/models/question_model.dart';
import 'package:atm_app/features/common/versions/data/models/aynaa_versions_model.dart';
import 'package:atm_app/features/common/versions/data/models/lesson_model.dart';
import 'package:atm_app/features/common/versions/data/models/subjects_model.dart';

import '../helper/enums.dart';

List<T> mapToListOfEntity<T>(List<Map<String, dynamic>> data, Entities value) {
  final List<T> resault;
  switch (value) {
    case Entities.versions:
      resault = data.map((item) {
        return AynaaVersionsModel.fromJson(item);
      }).toList() as List<T>;
      return resault;

    case Entities.subjects:
      resault = data.map((item) {
        return SubjectsModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.lessons:
      resault = data.map((item) {
        return LessonModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.exam:
      resault = data.map((item) {
        return ExamModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.examSections:
      resault = data.map((item) {
        return ExamSectionsModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.questions:
      resault = data.map((item) {
        return QuestionModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
  }
}
