import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';

import '../../../../../../core/shared_features/exams/data/data_source/exam_sections_data_source/exam_sections_remote_data_source.dart';

class AdminExamSectionsRemoteDataSourceImpl
    extends ExamSectionsRemoteDataSource {
  @override
  Future<List<ExamSectionsEntity>> fetchExamSections({required String examID}) {
    // TODO: implement fetchExamSections
    throw UnimplementedError();
  }
}
