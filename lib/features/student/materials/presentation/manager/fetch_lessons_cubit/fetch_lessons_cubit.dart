import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/helper/enums.dart';
import '../../../../../../core/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import '../../../../../../core/services/isar_storage_service.dart';
import '../../../../../../core/utils/set_up_service_locator.dart';

part 'fetch_lessons_state.dart';

class FetchLessonsCubit extends Cubit<FetchLessonsState> {
  final LessonsRepo lessonsRepo;
  final IsarStorageService isarStorageService;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchLessonsCubit(
      {required this.lessonsRepo, required this.isarStorageService})
      : super(FetchLessonsInitial()) {
    //_sync();
  }

  Future<void> fetchLessons(
      {required String subjectID, required String versionID}) async {
    emit(FetchLessonsLoading());
    final resault = await lessonsRepo.fetchLessons(
        subjectID: subjectID, versionID: versionID);
    resault.fold((failure) {
      emit(FetchLessonsFailure(errMessage: failure.errMessage));
    }, (lessons) {
      emit(FetchLessonsSuccess(lessons: lessons.reversed.toList()));
      _stream(subjectID: subjectID);
    });
  }

  void _stream({
    required String subjectID,
  }) {
    isarStorageService
        .watchAll<LessonEntity>(
            collectionType: CollentionType.lessons, id: subjectID)
        .listen((items) {
      if (isClosed) return;
      emit(
        FetchLessonsSuccess(lessons: items.reversed.toList()),
      );
      log('lessons upadted'); // Emit updated data
    });
  }

  _sync() {
    _subscription = getit.get<LessonsLocalDataSource>().lessonsStream.listen(
      (items) {
        if (isClosed) {
          return;
        }
        emit(FetchLessonsSuccess(lessons: items.reversed.toList()));
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
