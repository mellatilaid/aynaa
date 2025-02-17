import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_questions_state.dart';

class AddQuestionsCubit extends Cubit<AddQuestionsState> {
  AddQuestionsCubit() : super(AddQuestionsInitial());
}
