part of 'fetch_questions_cubit.dart';

@immutable
sealed class FetchQuestionsState {}

final class FetchQuestionsInitial extends FetchQuestionsState {}

final class FetchQuestionsLoading extends FetchQuestionsState {}

final class FetchQuestionsSuccuss extends FetchQuestionsState {
  final List<QuestionEntity> questions;
  FetchQuestionsSuccuss({required this.questions});
}

final class FetchQuestionsFailure extends FetchQuestionsState {
  final String errMessage;
  FetchQuestionsFailure({required this.errMessage});
}
