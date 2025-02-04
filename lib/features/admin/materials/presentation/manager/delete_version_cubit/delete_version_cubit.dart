import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_version_state.dart';

class DeleteVersionCubit extends Cubit<DeleteVersionState> {
  final VersionsRepo versionsRepo;
  DeleteVersionCubit({required this.versionsRepo})
      : super(DeleteVersionInitial());

  void deleteVersion({required AynaaVersionsEntity aynaaVersion}) async {
    emit(DeleteVersionLoading());
    final resault =
        await versionsRepo.deleteVersion(aynaaVersion: aynaaVersion);

    resault.fold((failure) {
      emit(DeleteVersionFailed(failure.errMessage));
    }, (lessons) {
      emit(DeleteVersionSuccess());
    });
  }
}
