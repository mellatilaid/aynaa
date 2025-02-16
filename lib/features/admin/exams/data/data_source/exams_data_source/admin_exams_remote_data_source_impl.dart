import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_remote_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';

class AdminExamsRemoteDataSourceImpl extends ExamsRemoteDataSource {
  final DataBase dataBase;
  final IsarStorageService isarStorageService;

  AdminExamsRemoteDataSourceImpl(
      {required this.dataBase, required this.isarStorageService});

  @override
  Future<List<ExamEntity>> fetchExams() async {
    final List<Map<String, dynamic>> data =
        await dataBase.getData(path: DbEnpoints.exams);

    List<ExamEntity> items = mapToListOfEntity(data, Entities.exams);
    /*isarStorageService.putAll(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<BackgroundServices<AynaaVersionsEntity>>()
        .startBackgroundDownloads(versions);*/
    return items;
  }
}
