import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/db_sync_service/db_sync_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

class AdminExamsLocalDataSourceImpl extends ExamsLocalDataSource {
  final ILocalDbService iLocalDbService;

  AdminExamsLocalDataSourceImpl({required this.iLocalDbService});
  @override
  Future<List<ExamEntity>> fetchExams({required String versionID}) async {
    final items = await iLocalDbService.filter(
      collentionType: Entities.exam,
      query: {kVersionID: versionID},
    );
    getit
        .get<DBSyncService<ExamEntity>>()
        .donwloadInBauckground(items, Entities.exam);
    return items as List<ExamEntity>;
  }

  @override
  Future<void> handleUpdate(
      {ExamEntity? exam,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await iLocalDbService.put<ExamEntity>(item: exam);

        break;
      case PostgressEventType.delete:
        await iLocalDbService.delete<ExamEntity>(id: id!);

        break;
      default:
    }
  }

  @override
  // TODO: implement versionsStream
  Stream<List<ExamEntity>> get versionsStream => throw UnimplementedError();
}
