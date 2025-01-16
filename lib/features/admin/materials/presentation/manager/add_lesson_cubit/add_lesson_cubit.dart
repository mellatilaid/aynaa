import 'package:atm_app/features/admin/materials/domain/repos/lessons_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_entity.dart';

part 'add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  final LessonsRepo lessonsRepo;
  AddLessonCubit(this.lessonsRepo) : super(AddLessonInitial());

  Future<void> addLesson({required LessonEntity lesson}) async {
    emit(AddLessonLoading());
    final result = await lessonsRepo.addLesson(lesson: lesson);
    result.fold((failure) {
      emit(AddLessonFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(AddLessonSuccuss());
    });
  }
}
