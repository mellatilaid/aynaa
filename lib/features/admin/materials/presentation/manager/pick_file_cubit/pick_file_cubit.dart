import 'package:atm_app/core/classes/pick_file.dart';
import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:meta/meta.dart';

part 'pick_file_state.dart';

class PickFileCubit extends Cubit<PickFileState> {
  final FilePickerHelper filePickerHelper;
  PickFileCubit(this.filePickerHelper) : super(PickFileInitial());

  void pickFile() async {
    emit(PickFileLoading());
    try {
      final file = await filePickerHelper.pickFile();

      if (file == null) {
        PickFileFailure(errMessage: 'No file selected.');
      } else {
        emit(PickFileLoaded(filePath: file));
      }
    } catch (e) {
      PickFileFailure(errMessage: 'No file selected.');
    }
  }

  emitCanacelState() {
    emit(PickFileCanceled());
  }
}
