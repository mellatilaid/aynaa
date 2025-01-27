import '../../features/admin/materials/data/models/aynaa_versions_model.dart';
import '../../features/admin/materials/data/models/lesson_model.dart';
import '../../features/admin/materials/data/models/subjects_model.dart';
import '../enums/entities.dart';

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
  }
}
