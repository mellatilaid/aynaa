import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/background_services.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

class AdminExamsRemoteDataSourceImpl extends ExamsRemoteDataSource {
  final DataBase dataBase;
  final LocalDBService isarStorageService;

  AdminExamsRemoteDataSourceImpl(
      {required this.dataBase, required this.isarStorageService});

  @override
  Future<List<ExamEntity>> fetchExams({required String versionID}) async {
    final List<Map<String, dynamic>> data = await dataBase
        .getData(path: DbEnpoints.exams, query: {kVersionID: versionID});

    List<ExamEntity> items = mapToListOfEntity(data, Entities.exams);
    isarStorageService.putAll(
        items: items, collentionType: CollentionType.exam);
    getit.get<BackgroundServices<ExamEntity>>().startBackgroundDownloads(items);
    return items;
  }
}
