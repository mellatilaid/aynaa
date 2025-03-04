import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/exam_sections_entity.dart';

part 'fetch_exam_sections_state.dart';

class FetchExamSectionsCubit extends Cubit<FetchExamSectionsState> {
  FetchExamSectionsCubit({
    required this.examSectionsRepo,
    required this.iLocalDBService,
  }) : super(FetchExamSectionsInitial());
  final ExamSectionsRepo examSectionsRepo;
  final ILocalDbService iLocalDBService;

  @override
  bool isClosed = false;

  Future<void> fetchExamSections({required String id}) async {
    emit(FetchExamSectionsLoading());
    final result = await examSectionsRepo.fetchExamSections(examID: id);
    result.fold(
        (failure) =>
            emit(FetchExamSectionsFailure(errMessage: failure.errMessage)),
        (sections) {
      emit(FetchExamSectionsSuccuss(sections: sections));
      _stream(id: id);
    });
  }

  void _stream({
    required String id,
  }) {
    iLocalDBService
        .watchAll<ExamSectionsEntity>(
            collectionType: Entities.examSections, id: id)
        .listen((items) {
      if (isClosed) return;

      emit(
        FetchExamSectionsSuccuss(sections: items),
      );
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close

    isClosed = true;
    return super.close();
  }
}
