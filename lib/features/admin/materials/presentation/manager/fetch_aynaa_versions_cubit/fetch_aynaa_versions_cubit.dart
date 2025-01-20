import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final VersionsRepo materialsRepo;
  FetchAynaaVersionsCubit(this.materialsRepo)
      : super(FetchAynaaVersionsInitial());

  Future<void> fetchAynaaVersions() async {
    emit(FetchAynaaVersionsLoading());
    final result = await materialsRepo.fetchAynaaVersions();
    result.fold(
      (failure) =>
          emit(FetchAynaaVersionsFailure(errMessage: failure.errMessage)),
      (aynaaVersions) => emit(
        FetchAynaaVersionsSucuss(aynaaVersions: aynaaVersions),
      ),
    );
  }
}
