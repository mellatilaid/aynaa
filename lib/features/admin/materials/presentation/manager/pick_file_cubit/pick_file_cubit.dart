import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pick_file_state.dart';

class PickFileCubit extends Cubit<PickFileState> {
  PickFileCubit() : super(PickFileInitial());
}
