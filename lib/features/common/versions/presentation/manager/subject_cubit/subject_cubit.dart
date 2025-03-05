import 'package:atm_app/features/common/versions/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'subject_state.dart';

class SubjectCubit extends Cubit<SubjectState> {
  final SubjectsRepo subjectsRepo;

  String? _filePath;
  SubjectCubit({required this.subjectsRepo}) : super(SubjectInitial());

  Future<void> addNewSubject({required SubjectsEntity subject}) async {
    emit(SubjectLoading());
    final result =
        await subjectsRepo.addSubject(subject: subject, filePath: _filePath);
    result.fold(
        (failure) => emit(SubjectFailure(errMessage: failure.errMessage)),
        (subjectID) => emit(SubjectSuccuss(versionID: subjectID)));
  }

  Future<void> updateSubject({required SubjectsEntity subject}) async {
    emit(SubjectLoading());
    final result =
        await subjectsRepo.updateSubject(subject: subject, filePath: _filePath);
    result.fold(
        (failure) => emit(SubjectFailure(errMessage: failure.errMessage)),
        (subjectID) => emit(SubjectSuccuss(versionID: subjectID)));
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
