part of 'add_exam_cubit.dart';

@immutable
sealed class AddExamState {}

final class AddExamInitial extends AddExamState {}

final class AddExamLoading extends AddExamState {}

final class AddExamSuccuss extends AddExamState {}

final class AddExamFailure extends AddExamState {
  final String errMessage;
  AddExamFailure({required this.errMessage});
}
