import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exam_section_state.dart';

class ExamSectionCubit extends Cubit<ExamSectionState> {
  final ExamSectionsRepo examSectionsRepo;
  ExamSectionCubit({required this.examSectionsRepo})
      : super(ExamSectionInitial());
  late String _filePath;
  Future<void> addExamSection({required ExamSectionsEntity examSection}) async {
    emit(ExamSectionLoading());

    final resault = await examSectionsRepo.addExamSection(
      examSection: examSection,
      filePath: _filePath,
    );

    resault.fold((failure) {
      emit(ExamSectionFailure(errMessage: failure.errMessage));
    }, (examID) {
      emit(ExamSectionSuccess(id: examID));
    });
  }

  Future<void> updateSection({required ExamSectionsEntity examSection}) async {
    emit(ExamSectionLoading());

    final resault = await examSectionsRepo.updateExamSection(
      section: examSection,
      filePath: _filePath,
    );

    resault.fold((failure) {
      emit(ExamSectionFailure(errMessage: failure.errMessage));
    }, (examID) {
      emit(ExamSectionSuccess(id: examID));
    });
  }

  Future<void> deleteExamSection(
      {required ExamSectionsEntity examSection}) async {
    emit(ExamSectionLoading());

    final resault = await examSectionsRepo.deleteExamSection(
      examSection: examSection,
    );

    resault.fold((failure) {
      emit(ExamSectionFailure(errMessage: failure.errMessage));
    }, (sucuss) {
      emit(DeleteExamSuccuss());
    });
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
