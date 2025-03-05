part of 'lesson_cubit.dart';

@immutable
sealed class LessonState {}

final class LessonInitial extends LessonState {}

final class LessonLoading extends LessonState {}

final class LessonSuccuss extends LessonState {}

final class LessonFailure extends LessonState {
  final String errMessage;
  LessonFailure({required this.errMessage});
}
