part of 'add_new_subject_cubit.dart';

@immutable
sealed class AddNewSubjectState {}

final class AddNewSubjectInitial extends AddNewSubjectState {}

final class AddNewSubjectLoading extends AddNewSubjectState {}

final class AddNewSubjectFailure extends AddNewSubjectState {
  final String errMessage;
  AddNewSubjectFailure({required this.errMessage});
}

final class AddNewSubjectSuccuss extends AddNewSubjectState {}
