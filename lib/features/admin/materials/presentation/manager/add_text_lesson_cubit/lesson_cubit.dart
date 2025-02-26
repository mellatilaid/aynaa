import 'dart:developer';

import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'lesson_state.dart';

class LessonCubit extends Cubit<LessonState> {
  final LessonsRepo lessonsRepo;
  LessonCubit(this.lessonsRepo) : super(LessonInitial());
  String? _versionID;
  String? _subjectID;
  String? _versionName;
  String? _subjectName;
  String? _filePath;
  Future<void> addLesson({required LessonEntity lesson}) async {
    emit(LessonLoading());
    final result =
        await lessonsRepo.addTextLesson(lesson: lesson, filePath: _filePath);
    result.fold((failure) {
      emit(LessonFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(LessonSuccuss());
    });
  }

  Future<void> updateLesson({required LessonEntity lesson}) async {
    emit(LessonLoading());
    final result =
        await lessonsRepo.updateLesson(lesson: lesson, filePath: _filePath);
    result.fold((failure) {
      emit(LessonFailure(errMessage: failure.errMessage));
    }, (success) {
      emit(LessonSuccuss());
    });
  }

  void resetState() {
    emit(LessonInitial());
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

  void setFilePath(String filePath) {
    _filePath = filePath;
    log(_filePath ?? 'subject name is null');
  }

  String? get subjectName => _subjectName;
  String? get versionID => _versionID;

  // Getter for subjectID
  String? get subjectID => _subjectID;
}
