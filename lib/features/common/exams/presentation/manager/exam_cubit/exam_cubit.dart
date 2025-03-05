import 'package:atm_app/features/common/exams/domain/entities/exam_entity.dart';
import 'package:atm_app/features/common/exams/domain/repos/exams_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  final ExamsRepo examsRepo;
  ExamCubit({required this.examsRepo}) : super(ExamInitial());

  late String _filePath;
  Future<void> addExam({required ExamEntity exam}) async {
    emit(ExamLoading());

    final resault = await examsRepo.addExam(exam: exam, filePath: _filePath);

    resault.fold((failure) {
      emit(ExamFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(ExamSuccuss(id: succuss));
    });
  }

  Future<void> updateExam({required ExamEntity exam}) async {
    emit(ExamLoading());

    final resault = await examsRepo.updateExam(exam: exam, filePath: _filePath);

    resault.fold((failure) {
      emit(ExamFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(ExamSuccuss(id: succuss));
    });
  }

  Future<void> deleteExam({required ExamEntity exam}) async {
    emit(ExamLoading());

    final resault = await examsRepo.deleteExam(exam: exam);

    resault.fold((failure) {
      emit(ExamFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(DeleteExamSuccuss());
    });
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
