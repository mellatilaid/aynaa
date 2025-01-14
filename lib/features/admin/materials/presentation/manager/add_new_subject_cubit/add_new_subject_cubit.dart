import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/subjects_entity.dart';

part 'add_new_subject_state.dart';

class AddNewSubjectCubit extends Cubit<AddNewSubjectState> {
  final SubjectsRepo subjectsRepo;
  AddNewSubjectCubit({required this.subjectsRepo})
      : super(AddNewSubjectInitial());

  Future<void> addNewSubject({required SubjectsEntity subject}) async {
    emit(AddNewSubjectLoading());
    final result = await subjectsRepo.addSubject(subject: subject);
    result.fold(
        (failure) => emit(AddNewSubjectFailure(errMessage: failure.errMessage)),
        (sucuss) => emit(AddNewSubjectSuccuss()));
  }
}
