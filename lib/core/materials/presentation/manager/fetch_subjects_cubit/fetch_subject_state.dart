part of 'fetch_subject_cubit.dart';

@immutable
sealed class FetchSubjectState extends BaseState {}

final class FetchSubjectInitial extends FetchSubjectState {}

final class FetchSubjectLoading extends FetchSubjectState {}

final class FetchSubjectFailure extends FetchSubjectState {
  final String errMessage;
  FetchSubjectFailure({required this.errMessage});
}

final class FetchSubjectSucuss extends FetchSubjectState {
  final List<SubjectsEntity> subjects;
  FetchSubjectSucuss({required this.subjects});
}
