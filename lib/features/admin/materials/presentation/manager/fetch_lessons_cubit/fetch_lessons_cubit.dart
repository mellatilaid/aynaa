import 'dart:async';

import 'package:atm_app/features/admin/materials/data/data_source/lessons_data_source/lessons_local_data_source.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/utils/set_up_service_locator.dart';
import '../../../domain/entities/lesson_entity.dart';
import '../../../domain/repos/lessons_repo.dart';

part 'fetch_lessons_state.dart';

class FetchLessonsCubit extends Cubit<FetchLessonsState> {
  final LessonsRepo lessonsRepo;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchLessonsCubit({required this.lessonsRepo})
      : super(FetchLessonsInitial()) {
    _sync();
  }

  Future<void> fetchLessons(
      {required String subjectID, required String versionID}) async {
    emit(FetchLessonsLoading());
    final resault = await lessonsRepo.fetchLessons(
        subjectID: subjectID, versionID: versionID);
    resault.fold((failure) {
      emit(FetchLessonsFailure(errMessage: failure.errMessage));
    }, (lessons) {
      emit(FetchLessonsSuccess(lessons: lessons));
    });
  }

  _sync() {
    _subscription = getit.get<LessonsLocalDataSource>().lessonsStream.listen(
      (subjects) {
        if (isClosed) {
          return;
        }
        emit(FetchLessonsSuccess(lessons: subjects));
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
