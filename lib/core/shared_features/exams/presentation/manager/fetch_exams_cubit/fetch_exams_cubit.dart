import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_exams_state.dart';

class FetchExamsCubit extends Cubit<FetchExamsState> {
  FetchExamsCubit({
    required this.examsRepo,
    required this.iLocalDbService,
  }) : super(FetchExamsInitial());
  final ExamsRepo examsRepo;
  final ILocalDbService iLocalDbService;

  @override
  bool isClosed = false;

  Future<void> fetchExams({required String versionID}) async {
    emit(FetchExamsLoading());
    final result = await examsRepo.fetchExams(versionID: versionID);
    result.fold(
        (failure) => emit(FetchExamsFailure(errMessage: failure.errMessage)),
        (exams) {
      emit(FetchExamsSuccuss(exams: exams));
      _stream(id: versionID);
    });
  }

  void _stream({
    required String id,
  }) {
    iLocalDbService
        .watchAll<ExamEntity>(collectionType: CollentionType.exam, id: id)
        .listen((items) {
      if (isClosed) return;

      emit(
        FetchExamsSuccuss(exams: items),
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
