import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_lesson_state.dart';

class AddLessonCubit extends Cubit<AddLessonState> {
  AddLessonCubit() : super(AddLessonInitial());
}
