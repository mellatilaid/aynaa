import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/entities/question_entity.dart';

abstract class QuestionsLocalDataSource {
  Future<List<QuestionEntity>> fetchQuestions({required String sectionID});
  Future<void> handleUpdate(
      {QuestionEntity? item,
      String? id,
      required PostgressEventType eventType});
  Stream<List<ExamEntity>> get versionsStream;
}

class QuestionsLocalDataSourceImpl extends QuestionsLocalDataSource {
  final ILocalDbService iLocalDbService;
  QuestionsLocalDataSourceImpl({required this.iLocalDbService});
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
