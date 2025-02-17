import 'package:atm_app/core/shared_features/exams/domain/entities/question_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_questions_state.dart';

class FetchQuestionsCubit extends Cubit<FetchQuestionsState> {
  FetchQuestionsCubit() : super(FetchQuestionsInitial());
}
