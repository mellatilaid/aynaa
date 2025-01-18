import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_entity.dart';
import '../../../domain/repos/lessons_repo.dart';

part 'fetch_lessons_state.dart';

class FetchLessonsCubit extends Cubit<FetchLessonsState> {
  final LessonsRepo lessonsRepo;
  FetchLessonsCubit({required this.lessonsRepo}) : super(FetchLessonsInitial());

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
}
