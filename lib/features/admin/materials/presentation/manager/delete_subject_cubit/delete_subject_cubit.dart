import 'package:atm_app/features/admin/materials/domain/entities/subjects_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_subject_state.dart';

class DeleteSubjectCubit extends Cubit<DeleteSubjectState> {
  final SubjectsRepo subjectsRepo;
  DeleteSubjectCubit({required this.subjectsRepo})
      : super(DeleteSubjectInitial());

  Future<void> deleteSubject({required SubjectsEntity subject}) async {
    emit(DeleteSubjectLoading());

    final resault = await subjectsRepo.deleteSubject(subject: subject);
    resault.fold((failure) {
      emit(DeleteSubjectFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(DeleteSubjectSuccess());
    });
  }
}
