import 'package:atm_app/core/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/core/materials/data/models/lesson_model.dart';
import 'package:atm_app/core/materials/data/models/subjects_model.dart';
import 'package:atm_app/core/shared_features/exams/data/models/exam_model.dart';
import 'package:atm_app/core/shared_features/exams/data/models/exam_sections_model.dart';
import 'package:atm_app/core/shared_features/exams/data/models/question_model.dart';

import '../helper/enums.dart';

List<T> mapToListOfEntity<T>(List<Map<String, dynamic>> data, Entities value) {
  final List<T> resault;
  switch (value) {
    case Entities.version:
      resault = data.map((item) {
        return AynaaVersionsModel.fromMap(item);
      }).toList() as List<T>;
      return resault;

    case Entities.subject:
      resault = data.map((item) {
        return SubjectsModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.lesson:
      resault = data.map((item) {
        return LessonModel.fromMap(item);
      }).toList() as List<T>;
      return resault;
    case Entities.exams:
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
