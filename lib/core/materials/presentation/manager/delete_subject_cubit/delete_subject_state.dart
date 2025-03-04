part of 'delete_subject_cubit.dart';

@immutable
sealed class DeleteSubjectState {}

final class DeleteSubjectInitial extends DeleteSubjectState {}

final class DeleteSubjectLoading extends DeleteSubjectState {}

final class DeleteSubjectSuccess extends DeleteSubjectState {}

final class DeleteSubjectFailure extends DeleteSubjectState {
  final String errMessage;
  DeleteSubjectFailure({required this.errMessage});
}
