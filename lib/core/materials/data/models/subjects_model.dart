import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/mixins/mappable.dart';

import '../../../../../../core/const/remote_db_const.dart';

class SubjectsModel extends SubjectsEntity with Mappable {
  SubjectsModel(
      {required super.entityID,
      required super.subjectName,
      required super.versionName,
      required super.url,
      required super.versionID,
      required super.localFilePath});

  /*factory SubjectsModel.fromSupabase(Map<String, dynamic> data) {
    return SubjectsModel(id: data[kID].toString(), subjectName: data[kName]);
  }*/

  factory SubjectsModel.fromSubjectEntity(SubjectsEntity subject) {
    return SubjectsModel(
        entityID: subject.entityID,
        subjectName: subject.subjectName,
        versionName: subject.versionName,
        url: subject.url,
        versionID: subject.versionID,
        localFilePath: subject.localFilePath);
  }

  @override
  toMap() {
    return {
      kUrl: url,
      kVersionID: versionID,
      kVersionName: versionName,
      kSubjectName: subjectName,
    };
  }

  static SubjectsModel fromMap(Map<String, dynamic> data) {
    return SubjectsModel(
      entityID: data[kUuid].toString(),
      subjectName: data[kSubjectName],
      versionID: data[kVersionID],
      url: data[kUrl],
      versionName: data[kVersionName],
      localFilePath: data[kLocalFilePath],
    );
  }
}
