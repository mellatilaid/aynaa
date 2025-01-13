import 'package:atm_app/const.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

class SubjectsModel extends SubjectsEntity {
  @override
  final String id;
  @override
  final String subjectName;

  SubjectsModel({required this.id, required this.subjectName})
      : super(id: id, subjectName: subjectName);

  factory SubjectsModel.fromSupabase(Map<String, dynamic> data) {
    return SubjectsModel(id: data[KID].toString(), subjectName: data[kName]);
  }

  factory SubjectsModel.fromSubjectEntity(SubjectsEntity subject) {
    return SubjectsModel(
        id: subject.id ?? '0', subjectName: subject.subjectName);
  }

  toMap() {
    return {KID: id, kName: subjectName};
  }
}
