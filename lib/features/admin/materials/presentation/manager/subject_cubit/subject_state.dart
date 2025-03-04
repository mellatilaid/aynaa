part of 'subject_cubit.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

final class SubjectLoading extends SubjectState {}

final class NoInternetState extends SubjectState {}

final class SubjectFailure extends SubjectState {
  final String errMessage;
  SubjectFailure({required this.errMessage});
}

final class SubjectSuccuss extends SubjectState {
  final String versionID;
  SubjectSuccuss({required this.versionID});
}
