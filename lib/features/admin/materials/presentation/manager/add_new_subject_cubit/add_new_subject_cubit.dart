import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_new_subject_state.dart';

class AddNewSubjectCubit extends Cubit<AddNewSubjectState> {
  AddNewSubjectCubit() : super(AddNewSubjectInitial());
}
