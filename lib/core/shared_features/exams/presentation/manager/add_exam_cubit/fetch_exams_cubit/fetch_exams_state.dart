part of 'fetch_exams_cubit.dart';

@immutable
sealed class FetchExamsState {}

final class FetchExamsInitial extends FetchExamsState {}

final class FetchExamsLoading extends FetchExamsState {}

final class FetchExamsSuccuss extends FetchExamsState {
  final List<ExamEntity> exams;
  FetchExamsSuccuss({required this.exams});
}

final class FetchExamsFailure extends FetchExamsState {
  final String errMessage;
  FetchExamsFailure({required this.errMessage});
}
