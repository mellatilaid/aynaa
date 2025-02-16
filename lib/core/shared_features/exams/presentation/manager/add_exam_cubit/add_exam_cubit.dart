import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exam_state.dart';

class AddExamCubit extends Cubit<AddExamState> {
  AddExamCubit() : super(AddExamInitial());
}
