part of 'exam_cubit.dart';

@immutable
sealed class ExamState {}

final class ExamInitial extends ExamState {}

final class ExamLoading extends ExamState {}

final class ExamSuccuss extends ExamState {
  final String id;
  ExamSuccuss({required this.id});
}

final class DeleteExamSuccuss extends ExamState {}

final class ExamFailure extends ExamState {
  final String errMessage;
  ExamFailure({required this.errMessage});
}
