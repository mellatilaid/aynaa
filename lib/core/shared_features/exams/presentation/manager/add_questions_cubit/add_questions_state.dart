part of 'add_questions_cubit.dart';

@immutable
sealed class AddQuestionsState {}

final class AddQuestionsInitial extends AddQuestionsState {}

final class AddQuestionsLoading extends AddQuestionsState {}

final class AddQuestionsSuccuss extends AddQuestionsState {}

final class AddQuestionsFailure extends AddQuestionsState {
  final String errMessage;
  AddQuestionsFailure({required this.errMessage});
}
