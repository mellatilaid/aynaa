part of 'questions_cubit.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class QuestionsLoading extends QuestionsState {}

final class QuestionsSuccuss extends QuestionsState {
  final String questionID;
  QuestionsSuccuss({required this.questionID});
}

final class DeleteQuestionSuccuss extends QuestionsState {}

final class QuestionsFailure extends QuestionsState {
  final String errMessage;
  QuestionsFailure({required this.errMessage});
}
