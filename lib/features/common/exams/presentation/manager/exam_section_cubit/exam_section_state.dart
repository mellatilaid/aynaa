part of 'exam_section_cubit.dart';

@immutable
sealed class ExamSectionState {}

final class ExamSectionInitial extends ExamSectionState {}

final class ExamSectionLoading extends ExamSectionState {}

final class ExamSectionSuccess extends ExamSectionState {
  final String id;
  ExamSectionSuccess({required this.id});
}

final class DeleteExamSuccuss extends ExamSectionState {}

final class ExamSectionFailure extends ExamSectionState {
  final String errMessage;
  ExamSectionFailure({required this.errMessage});
}
