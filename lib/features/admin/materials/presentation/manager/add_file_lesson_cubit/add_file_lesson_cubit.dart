import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_file_lesson_state.dart';

class AddFileLessonCubit extends Cubit<AddFileLessonState> {
  AddFileLessonCubit() : super(AddFileLessonInitial());
}
