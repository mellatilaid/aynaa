part of 'add_file_lesson_cubit.dart';

@immutable
sealed class AddFileLessonState {}

final class AddFileLessonInitial extends AddFileLessonState {}

final class AddFileLessonLoading extends AddFileLessonState {
  final double progress;
  final Duration estimate;
  AddFileLessonLoading({required this.progress, required this.estimate});
}

final class AddFileLessonFailure extends AddFileLessonState {
  final String errMessage;
  AddFileLessonFailure({required this.errMessage});
}

final class AddFileLessonSuccess extends AddFileLessonState {}
