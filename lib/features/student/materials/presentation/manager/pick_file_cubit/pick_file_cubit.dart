import 'package:atm_app/core/classes/pick_file.dart';
import 'package:bloc/bloc.dart';
import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

part 'pick_file_state.dart';

class PickFileCubit extends Cubit<PickFileState> {
  final FilePickerHelper filePickerHelper;
  PickFileCubit(this.filePickerHelper) : super(PickFileInitial());

  void pickFile(
      {FileType fileType = FileType.custom,
      List<String>? allowedExtensions}) async {
    emit(PickFileLoading());
    try {
      final file = await filePickerHelper.pickFile(
        fileType: fileType,
        allowedExtensions: allowedExtensions,
      );

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
