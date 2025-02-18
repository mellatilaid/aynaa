import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/background_services.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/exams_data_source/exams_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';

class AdminExamsLocalDataSourceImpl extends ExamsLocalDataSource {
  final IsarStorageService isarStorageService;

  AdminExamsLocalDataSourceImpl({required this.isarStorageService});
  @override
  Future<List<ExamEntity>> fetchExams({required String versionID}) async {
    final items = await isarStorageService.filter(
      collentionType: CollentionType.exam,
      query: {kVersionID: versionID},
    );
    getit.get<BackgroundServices<ExamEntity>>().startBackgroundDownloads(items);
    return items as List<ExamEntity>;
  }

  @override
  Future<void> handleUpdate(
      {ExamEntity? exam,
      String? id,
      required PostgressEventType eventType}) async {
    switch (eventType) {
      case PostgressEventType.insert:
        await isarStorageService.put(
            item: exam, collentionType: CollentionType.exam);

        break;
      case PostgressEventType.delete:
        await isarStorageService.delete(
            id: id!, collentionType: CollentionType.exam);

        break;
      default:
    }
  }

  @override
  // TODO: implement versionsStream
  Stream<List<ExamEntity>> get versionsStream => throw UnimplementedError();
}
