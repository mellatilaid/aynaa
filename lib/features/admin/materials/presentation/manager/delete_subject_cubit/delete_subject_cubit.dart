import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_subject_state.dart';

class DeleteSubjectCubit extends Cubit<DeleteSubjectState> {
  DeleteSubjectCubit() : super(DeleteSubjectInitial());
}
