import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

import '../../../../../../core/const/local_db_const.dart';
import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/enums/entities.dart';
import '../../../../../../core/functions/map_to_list_of_entity.dart';
import '../../../../../../core/services/hive_service.dart';
import '../../../../../../core/utils/db_enpoints.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
}

class SubjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;
  final HiveCache hiveCache;
  SubjectsRemoteDataSourceImpl(
      {required this.dataBase, required this.hiveCache});

  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final List<Map<String, dynamic>> aynaaSubjects = await dataBase
        .getData(path: DbEnpoints.subjects, query: {kVersionID: versionID});

    List<SubjectsEntity> subjects =
        mapToListOfEntity(aynaaSubjects, Entities.subject);
    hiveCache.putAll(boxName: kSubjectsBox, items: subjects);
    return subjects;
  }
}
