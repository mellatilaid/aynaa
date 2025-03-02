import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/data/data_source/questions_data_source/questions_local_data_source.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';

class AdminQuestionsLocalDataSourceImpl extends QuestionsLocalDataSource {
  final ILocalDbService iLocalDbService;
  AdminQuestionsLocalDataSourceImpl({required this.iLocalDbService});
  @override
  Future<List<QuestionEntity>> fetchQuestions(
      {required String sectionID}) async {
    final items = await iLocalDbService.filter(
      collentionType: Entities.questions,
      query: {kSectionID: sectionID},
    ) as List<QuestionEntity>;

    return items;
  }

  @override
  Future<void> handleUpdate(
      {QuestionEntity? item,
      String? id,
      required PostgressEventType eventType}) {
    // TODO: implement handleUpdate
    throw UnimplementedError();
  }

  @override
  // TODO: implement versionsStream
  Stream<List<ExamEntity>> get versionsStream => throw UnimplementedError();
}
