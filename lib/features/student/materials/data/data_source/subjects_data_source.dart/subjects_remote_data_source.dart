import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/services/background_services.dart';
import '../../../../../../core/utils/db_enpoints.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

class StudentSubjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;
  final IsarStorageService isarStorageService;
  StudentSubjectsRemoteDataSourceImpl(
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
    getit
        .get<BackgroundServices<SubjectsEntity>>()
        .startBackgroundDownloads(subjects);
    return subjects;
  }
}
