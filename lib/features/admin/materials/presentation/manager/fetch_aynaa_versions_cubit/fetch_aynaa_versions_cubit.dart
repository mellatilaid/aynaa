import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/materials_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final MaterialsRepo materialsRepo;
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
