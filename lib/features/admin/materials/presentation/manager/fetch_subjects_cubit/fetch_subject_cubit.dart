import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/subjects_entity.dart';

part 'fetch_subject_state.dart';

class FetchSubjectCubit extends Cubit<FetchSubjectState> {
  final SubjectsRepo subjectsRepo;
  FetchSubjectCubit(this.subjectsRepo) : super(FetchSubjectInitial());

  Future<void> fetchSubjects() async {
    emit(FetchSubjectLoading());
    final result = await subjectsRepo.fetchSubjects();
    result.fold(
      (failure) => emit(FetchSubjectFailure(errMessage: failure.errMessage)),
      (subjects) => emit(FetchSubjectSucuss(subjects: subjects)),
    );
  }
}
