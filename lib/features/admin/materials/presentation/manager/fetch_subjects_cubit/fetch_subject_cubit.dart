import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/features/admin/materials/data/data_source/subjects_data_source.dart/subjects_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/repos/subjects_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../domain/entities/subjects_entity.dart';

part 'fetch_subject_state.dart';

class FetchSubjectCubit extends Cubit<FetchSubjectState> {
  final SubjectsRepo subjectsRepo;
  final IsarStorageService isarStorageService;
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
      emit(FetchSubjectSucuss(subjects: subjects));
      _stream(id: versionID);
    });
  }

  void _stream({
    required String id,
  }) {
    isarStorageService
        .watchAll<SubjectsEntity>(
            collectionType: CollentionType.lessons, id: id)
        .listen((items) {
      if (isClosed) return;
      emit(
        FetchSubjectSucuss(subjects: items.reversed.toList()),
      );
      log('lessons upadted'); // Emit updated data
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
