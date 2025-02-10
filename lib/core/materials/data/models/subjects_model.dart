import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/mixins/mappable.dart';

import '../../../../../../core/const/remote_db_const.dart';

class SubjectsModel extends SubjectsEntity with Mappable {
  SubjectsModel(
    String entityID,
    String subjectName,
    String versionID,
    String url,
    String versionName,
    String? localFilePath,
  ) : super(
          entityID: entityID,
          subjectName: subjectName,
          versionID: versionID,
          url: url,
          versionName: versionName,
          localFilePath: localFilePath,
        );

  /*factory SubjectsModel.fromSupabase(Map<String, dynamic> data) {
    return SubjectsModel(id: data[kID].toString(), subjectName: data[kName]);
  }*/

  factory SubjectsModel.fromSubjectEntity(SubjectsEntity subject) {
    return SubjectsModel(
        subject.entityID,
        subject.subjectName,
        subject.versionID,
        subject.url,
        subject.versionName,
        subject.localFilePath);
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
      data[kUuid].toString(),
      data[kSubjectName],
      data[kVersionID],
      data[kUrl],
      data[kVersionName],
      data[kLocalFilePath],
    );
  }
}
