import 'package:atm_app/core/materials/domain/entities/lesson_entity.dart';
import 'package:atm_app/core/materials/domain/repos/lessons_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:meta/meta.dart';

part 'add_file_lesson_state.dart';

class AddFileLessonCubit extends Cubit<AddFileLessonState> {
  AddFileLessonCubit({required this.lessonsRepo})
      : super(AddFileLessonInitial());
  final LessonsRepo lessonsRepo;

  void startUpload(
      {required XFile file,
      required String uri,
      required LessonEntity lesson}) {
    lessonsRepo
        .addFileLesson(file: file, uri: uri, lesson: lesson)
        .listen((either) {
      either.fold((failure) {
        emit(AddFileLessonFailure(errMessage: failure.errMessage));
      }, (progress) {
        //if (progress == 1) emit(AddFileLessonSuccess());
        emit(
          AddFileLessonLoading(
            progress: progress,
            estimate: const Duration(seconds: 5),
          ),
        );
      }); // Update estimate as needed
    });
  }

  /*void pauseUpload() {
    lessonsRepo.pauseUpload();
  }

  Future<void> cancelUpload() async {
    final result = await lessonsRepo.cancelUpload();
    if (result) {
      emit(UploadState(progress: 0, estimate: const Duration()));
    }
  }*/
}

/*class UploadCubit extends Cubit<UploadState> {
  final UploadRepository repository;

  UploadCubit(this.repository) : super(UploadState());

  void startUpload(XFile file, Uri uri, Map<String, String> metadata) {
    repository.uploadFile(file, uri, metadata).listen((progress) {
      emit(UploadState(progress: progress, estimate: Duration(seconds: 5))); // Update estimate as needed
    });
  }

  void pauseUpload() {
    repository.pauseUpload();
  }

  Future<void> cancelUpload() async {
    final result = await repository.cancelUpload();
    if (result) {
      emit(UploadState(progress: 0, estimate: const Duration()));
    }
  }
}*/
