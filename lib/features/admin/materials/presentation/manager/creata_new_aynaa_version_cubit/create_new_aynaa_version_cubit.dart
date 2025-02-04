import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_new_aynaa_version_state.dart';

class CreateNewAynaaVersionCubit extends Cubit<CreateNewAynaaVersionState> {
  final VersionsRepo versionsRepo;
  CreateNewAynaaVersionCubit(this.versionsRepo)
      : super(CreateNewAynaaVersionInitial());

  Future<void> createNewAynaaVersion({required String versionName}) async {
    emit(CreateNewAynaaVersionLoading());
    final resault = await versionsRepo.setVersion(versionName: versionName);

    resault.fold((failure) {
      emit(CreateNewAynaaVersionFailure(errMessage: failure.errMessage));
    }, (succuss) {
      emit(CreateNewAynaaVersionSuccess());
    });
  }
}
