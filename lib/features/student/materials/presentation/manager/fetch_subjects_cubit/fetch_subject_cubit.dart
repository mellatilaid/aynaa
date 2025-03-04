import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/materials/data/data_source/subjects_data_source/subjects_local_data_source.dart';
import 'package:atm_app/core/materials/domain/repos/subjects_repo.dart';
import 'package:atm_app/core/services/local_db_service/local_d_b_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/materials/domain/entities/subjects_entity.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

part 'fetch_subject_state.dart';

class FetchSubjectCubit extends Cubit<FetchSubjectState> {
  final SubjectsRepo subjectsRepo;
  final LocalDbService isarStorageService;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchSubjectCubit(this.subjectsRepo, this.isarStorageService)
      : super(FetchSubjectInitial()) {
    //_sync();
  }

  Future<void> fetchSubjects({required String versionID}) async {
    emit(FetchSubjectLoading());
    final result = await subjectsRepo.fetchSubjects(versionID: versionID);
    result.fold(
        (failure) => emit(FetchSubjectFailure(errMessage: failure.errMessage)),
        (subjects) {
      emit(FetchSubjectSucuss(subjects: subjects.reversed.toList()));
      _stream(id: versionID);
    });
  }

  void _stream({
    required String id,
  }) {
    isarStorageService
        .watchAll<SubjectsEntity>(collectionType: Entities.subjects, id: id)
        .listen((items) {
      if (isClosed) return;

      emit(
        FetchSubjectSucuss(subjects: items.reversed.toList()),
      );
    });
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
