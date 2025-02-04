import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/enums/entities.dart';
import '../../../../../../core/utils/db_enpoints.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectsEntity>> fetchSubjects({required String versionID});
}

class SubjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;
  final IsarStorageService isarStorageService;
  SubjectsRemoteDataSourceImpl(
      {required this.dataBase, required this.isarStorageService});

  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final List<Map<String, dynamic>> aynaaSubjects = await dataBase
        .getData(path: DbEnpoints.subjects, query: {kVersionID: versionID});

    List<SubjectsEntity> subjects =
        mapToListOfEntity(aynaaSubjects, Entities.subject);
    isarStorageService.putAll(
      items: subjects,
      collentionType: CollentionType.subjects,
    );
    return subjects;
  }
}
