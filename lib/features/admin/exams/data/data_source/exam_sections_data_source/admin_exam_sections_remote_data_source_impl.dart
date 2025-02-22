import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/functions/map_to_list_of_entity.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';

class AdminExamSectionsRemoteDataSourceImpl
    extends ExamSectionsRemoteDataSource {
  final DataBase dataBase;
  final ILocalDbService iLocalDbService;

  AdminExamSectionsRemoteDataSourceImpl({
    required this.dataBase,
    required this.iLocalDbService,
  });

  @override
  Future<List<ExamSectionsEntity>> fetchExamSections(
      {required String examID}) async {
    final List<Map<String, dynamic>> data = await dataBase
        .getData(path: DbEnpoints.examSections, query: {kExamID: examID});

    List<ExamSectionsEntity> items =
        mapToListOfEntity(data, Entities.examSections);
    /*isarStorageService.putAll(
        items: versions, collentionType: CollentionType.versions);
    getit
        .get<BackgroundServices<AynaaVersionsEntity>>()
        .startBackgroundDownloads(versions);*/
    return items;
  }
}
