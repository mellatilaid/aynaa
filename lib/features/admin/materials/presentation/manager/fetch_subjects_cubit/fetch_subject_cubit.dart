import 'dart:async';
import 'dart:developer';

import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../domain/entities/subjects_entity.dart';

part 'fetch_subject_state.dart';

class FetchSubjectCubit extends Cubit<FetchSubjectState> {
  final SubjectsRepo subjectsRepo;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchSubjectCubit(this.subjectsRepo) : super(FetchSubjectInitial()) {
    _sync();
  }

  Future<void> fetchSubjects({required String versionID}) async {
    emit(FetchSubjectLoading());
    final result = await subjectsRepo.fetchSubjects(versionID: versionID);
    result.fold(
      (failure) => emit(FetchSubjectFailure(errMessage: failure.errMessage)),
      (subjects) => emit(FetchSubjectSucuss(subjects: subjects)),
    );
  }

  _sync() {
    _subscription = getit.get<SubjectsLocalDataSource>().subjectsStream.listen(
      (subjects) {
        if (isClosed) {
          log('cubit is closed');
          return;
        }
        emit(FetchSubjectSucuss(subjects: subjects));
      },
    );
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _subscription?.cancel();
    isClosed = true;
    return super.close();
  }
}
