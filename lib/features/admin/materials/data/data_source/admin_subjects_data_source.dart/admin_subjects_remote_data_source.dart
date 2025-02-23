import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_remote_data_source.dart';
import 'package:atm_app/core/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/utils/db_enpoints.dart';

class AdminSubjectsRemoteDataSourceImpl extends SubjectsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;
  final IDBSyncService storageSyncService;
  AdminSubjectsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
    required this.storageSyncService,
  });

  @override
  Future<List<SubjectsEntity>> fetchSubjects(
      {required String versionID}) async {
    final List<Map<String, dynamic>> aynaaSubjects = await dataBase
        .getData(path: DbEnpoints.subjects, query: {kVersionID: versionID});

    List<SubjectsEntity> subjects =
        mapToListOfEntity(aynaaSubjects, Entities.subjects);
    iLocalDbService.putAll<SubjectsEntity>(
      items: subjects,
      collentionType: Entities.subjects,
    );
    storageSyncService.donwloadInBauckground(subjects, Entities.subjects);
    return subjects;
  }
}
