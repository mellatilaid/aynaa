part of 'fetch_lessons_cubit.dart';

@immutable
sealed class FetchLessonsState {}

final class FetchLessonsInitial extends FetchLessonsState {}

final class FetchLessonsLoading extends FetchLessonsState {}

final class FetchLessonsSuccess extends FetchLessonsState {
  final List<LessonEntity> lessons;

  FetchLessonsSuccess({required this.lessons});
}

final class FetchLessonsFailure extends FetchLessonsState {
  final String errMessage;

  FetchLessonsFailure({required this.errMessage});
}
