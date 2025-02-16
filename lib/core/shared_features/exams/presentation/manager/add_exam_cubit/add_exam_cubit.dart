import 'package:atm_app/core/shared_features/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/core/shared_features/exams/domain/repos/exams_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exam_state.dart';

class AddExamCubit extends Cubit<AddExamState> {
  final ExamsRepo examsRepo;
  AddExamCubit({required this.examsRepo}) : super(AddExamInitial());

  late String _filePath;
  Future<void> addExam({required ExamEntity exam}) async {
    emit(AddExamLoading());

    final resault = await examsRepo.addExam(exam: exam, filePath: _filePath);

    resault.fold((failure) {
      emit(AddExamFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(AddExamSuccuss());
    });
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
