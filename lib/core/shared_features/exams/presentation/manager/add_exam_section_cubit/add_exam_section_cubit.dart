import 'package:atm_app/core/shared_features/exams/domain/entities/exam_sections_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exam_sections_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exam_section_state.dart';

class AddExamSectionCubit extends Cubit<AddExamSectionState> {
  final ExamSectionsRepo examSectionsRepo;
  AddExamSectionCubit({required this.examSectionsRepo})
      : super(AddExamSectionInitial());
  late String _filePath;
  Future<void> addExam({required ExamSectionsEntity examSection}) async {
    emit(AddExamSectionLoading());

    final resault = await examSectionsRepo.addExamSection(
      examSection: examSection,
      filePath: _filePath,
    );

    resault.fold((failure) {
      emit(AddExamSectionFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(AddExamSectionSuccess());
    });
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
