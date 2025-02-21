import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/core/services/storage_sync_service/storage_sync_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';

class AdminExamSectionsLocalDataSourceImpl extends ExamSectionsLocalDataSource {
  final LocalDBService isarStorageService;

  AdminExamSectionsLocalDataSourceImpl({required this.isarStorageService});

  @override
  Future<List<ExamEntity>> fetchExamSections({required String examID}) async {
    final items = await isarStorageService.filter(
      collentionType: CollentionType.exam,
      query: {kExamID: examID},
    );
    getit.get<StorageSyncService<ExamEntity>>().donwloadInBauckground(items);
    return items as List<ExamEntity>;
  }

  @override
  Future<void> handleUpdate(
      {ExamSectionsEntity? item,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put<ExamSectionsEntity>(item: item);

        break;
      case PostgressEventType.delete:
        await isarStorageService.delete(
            id: id!, collentionType: CollentionType.exam);

        break;
      default:
    }
  }
}
