part of 'add_lesson_cubit.dart';

@immutable
sealed class AddLessonState {}

final class AddLessonInitial extends AddLessonState {}

final class AddLessonLoading extends AddLessonState {}

final class AddLessonSuccuss extends AddLessonState {}

final class AddLessonFailure extends AddLessonState {
  final String errMessage;
  AddLessonFailure({required this.errMessage});
}
