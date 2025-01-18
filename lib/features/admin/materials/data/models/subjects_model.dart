import 'package:atm_app/const.dart';
import 'package:atm_app/core/mixins/mappable.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

class SubjectsModel extends SubjectsEntity with Mappable {
  @override
  final String id;
  @override
  final String subjectName;
  @override
  final String versionID;

  SubjectsModel(
      {required this.id, required this.subjectName, required this.versionID})
      : super(id: id, subjectName: subjectName, versionID: versionID);

  /*factory SubjectsModel.fromSupabase(Map<String, dynamic> data) {
    return SubjectsModel(id: data[kID].toString(), subjectName: data[kName]);
  }*/

  factory SubjectsModel.fromSubjectEntity(SubjectsEntity subject) {
    return SubjectsModel(
        id: subject.id ?? '0',
        subjectName: subject.subjectName,
        versionID: subject.versionID);
  }

  @override
  toMap() {
    return {
      kName: subjectName,
      kVersionID: versionID,
    };
  }

  static SubjectsModel fromMap(Map<String, dynamic> data) {
    return SubjectsModel(
        id: data[kID].toString(),
        subjectName: data[kName],
        versionID: data[kVersionID]);
  }
}
