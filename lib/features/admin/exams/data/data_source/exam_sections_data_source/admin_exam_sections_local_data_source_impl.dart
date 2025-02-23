import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/db_sync_service/db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';

class AdminExamSectionsLocalDataSourceImpl extends ExamSectionsLocalDataSource {
  final ILocalDbService iLocalDbService;

  AdminExamSectionsLocalDataSourceImpl({required this.iLocalDbService});

  @override
  Future<List<ExamEntity>> fetchExamSections({required String examID}) async {
    final items = await iLocalDbService.filter(
      collentionType: Entities.exam,
      query: {kExamID: examID},
    );
    getit.get<DBSyncService<ExamEntity>>().donwloadInBauckground(
          items,
          Entities.exam,
        );
    return items as List<ExamEntity>;
  }

  @override
  Future<void> handleUpdate(
      {ExamSectionsEntity? item,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await iLocalDbService.put<ExamSectionsEntity>(item: item);

        break;
      case PostgressEventType.delete:
        await iLocalDbService.delete(id: id!);

        break;
      default:
    }
  }
}
