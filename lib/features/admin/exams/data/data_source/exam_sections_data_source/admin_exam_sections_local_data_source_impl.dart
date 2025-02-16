import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_local_data_source.dart';

class AdminExamSectionsLocalDataSourceImpl extends ExamSectionsLocalDataSource {
  @override
  Future<List<ExamEntity>> fetchExamSections({required String examID}) {
    // TODO: implement fetchExamSections
    throw UnimplementedError();
  }

  @override
  Future<void> handleUpdate(
      {ExamSectionsEntity? examSectionsEntity,
      String? id,
      required PostgressEventType eventType}) {
    // TODO: implement handleUpdate
    throw UnimplementedError();
  }
}
