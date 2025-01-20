import 'dart:developer';

import 'package:atm_app/features/admin/materials/domain/repos/lessons_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/lesson_entity.dart';

part 'add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  final LessonsRepo lessonsRepo;
  AddLessonCubit(this.lessonsRepo) : super(AddLessonInitial());
  String? _versionID;
  String? _subjectID;
  String? _versionName;
  String? _subjectName;

  Future<void> addLesson({required LessonEntity lesson}) async {
    emit(AddLessonLoading());
    final result = await lessonsRepo.addLesson(lesson: lesson);
    result.fold((failure) {
      emit(AddLessonFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(AddLessonSuccuss());
    });
  }

  void resetState() {
    emit(AddLessonInitial());
  }

  void setVersionIDAndName(String versionID, String versionName) {
    _versionID = versionID;
    _versionName = versionName;
    log(_versionID ?? 'version id is null');
  }

  void setSubjectIDAndName(String subjectID, String subjectName) {
    _subjectID = subjectID;
    _subjectName = subjectName;
    log(_subjectID ?? 'subject id is null');
  }

  void setVersionName(String versionName) {
    _versionName = versionName;
    log(_versionName ?? 'version name is null');
  }

  String? get versionName => _versionName;

  void setSubjectName(String subjectName) {
    _subjectName = subjectName;
    log(subjectName ?? 'subject name is null');
  }

  String? get subjectName => _subjectName;
  String? get versionID => _versionID;

  // Getter for subjectID
  String? get subjectID => _subjectID;
}
