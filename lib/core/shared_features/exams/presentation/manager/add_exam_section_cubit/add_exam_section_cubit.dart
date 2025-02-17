import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_exam_section_state.dart';

class AddExamSectionCubit extends Cubit<AddExamSectionState> {
  AddExamSectionCubit() : super(AddExamSectionInitial());
}
