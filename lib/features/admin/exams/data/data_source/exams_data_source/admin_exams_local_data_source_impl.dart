import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_d_b_service.dart';
import 'package:atm_app/core/services/storage_sync_service/storage_sync_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

class AdminExamsLocalDataSourceImpl extends ExamsLocalDataSource {
  final LocalDBService isarStorageService;

  AdminExamsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<ExamEntity>> fetchExams({required String versionID}) async {
    final items = await isarStorageService.filter(
      collentionType: CollentionType.exam,
      query: {kVersionID: versionID},
    );
    getit.get<StorageSyncService<ExamEntity>>().donwloadInBauckground(items);
    return items as List<ExamEntity>;
  }

  @override
  Future<void> handleUpdate(
      {ExamEntity? exam,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put<ExamEntity>(item: exam);

        break;
      case PostgressEventType.delete:
        await isarStorageService.delete<ExamEntity>(
            id: id!, collentionType: CollentionType.exam);

        break;
      default:
    }
  }

  @override
  // TODO: implement versionsStream
  Stream<List<ExamEntity>> get versionsStream => throw UnimplementedError();
}
