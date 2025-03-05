import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_sections_entity.dart';

abstract class ExamSectionsLocalDataSource {
  Future<List<ExamSectionsEntity>> fetchExamSections({required String examID});
  Future<void> updateCachedSection({required ExamSectionsEntity section});

  Future<void> handleUpdate(
      {ExamSectionsEntity? item,
      String? id,
      required PostgressEventType eventType});
}

class ExamSectionsLocalDataSourceImpl extends ExamSectionsLocalDataSource {
  final ILocalDbService iLocalDbService;
  final IDBSyncService idbSyncService;
  ExamSectionsLocalDataSourceImpl({
    required this.iLocalDbService,
    required this.idbSyncService,
  });

  @override
  Future<List<ExamSectionsEntity>> fetchExamSections(
      {required String examID}) async {
    final items = await iLocalDbService.filter(
      collentionType: Entities.examSections,
      query: {kExamID: examID},
    );
    idbSyncService.donwloadInBauckground(
      items,
      Entities.examSections,
    );
    return items as List<ExamSectionsEntity>;
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

  @override
  Future<void> updateCachedSection(
      {required ExamSectionsEntity section}) async {
    await iLocalDbService.put<ExamSectionsEntity>(item: section);
  }
}
