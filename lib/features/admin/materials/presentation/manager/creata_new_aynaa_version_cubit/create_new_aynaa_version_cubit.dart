import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_new_aynaa_version_state.dart';

class CreateNewAynaaVersionCubit extends Cubit<CreateNewAynaaVersionState> {
  final VersionsRepo versionsRepo;
  CreateNewAynaaVersionCubit(this.versionsRepo)
      : super(CreateNewAynaaVersionInitial());
  late String _filePath;
  Future<void> createNewAynaaVersion(
      {required AynaaVersionsEntity version}) async {
    emit(CreateNewAynaaVersionLoading());

    final resault =
        await versionsRepo.setVersion(version: version, filePath: _filePath);

    resault.fold((failure) {
      emit(CreateNewAynaaVersionFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(CreateNewAynaaVersionSuccess());
    });
  }

  void setFilePath(String filePath) => _filePath = filePath;
}
