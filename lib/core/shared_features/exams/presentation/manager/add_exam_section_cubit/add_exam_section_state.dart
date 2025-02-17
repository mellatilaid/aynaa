part of 'add_exam_section_cubit.dart';

@immutable
sealed class AddExamSectionState {}

final class AddExamSectionInitial extends AddExamSectionState {}

final class AddExamSectionLoading extends AddExamSectionState {}

final class AddExamSectionSuccess extends AddExamSectionState {
  final String id;
  AddExamSectionSuccess({required this.id});
}

final class AddExamSectionFailure extends AddExamSectionState {
  final String errMessage;
  AddExamSectionFailure({required this.errMessage});
}
