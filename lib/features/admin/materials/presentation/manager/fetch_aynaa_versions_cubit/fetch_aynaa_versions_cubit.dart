import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final VersionsRepo materialsRepo;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchAynaaVersionsCubit(this.materialsRepo)
      : super(FetchAynaaVersionsInitial()) {
    sync();
  }
  sync() {
    _subscription = getit.get<VersionsLocalDataSource>().versionsStream.listen(
      (versions) {
        if (isClosed) {
          log('cubit is closed');
          return;
        }
        emit(FetchAynaaVersionsSucuss(aynaaVersions: versions));
      },
    );
    /*_subscription = VersionsLocalDataSourceImpl(
            hiveCache: BaseHiveCache<AynaaVersionsEntity>())
        .versionsStream
        .listen((versions) {
      emit(FetchAynaaVersionsSucuss(aynaaVersions: versions));
    });*/
  }

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

  @override
  Future<void> close() {
    // TODO: implement close
    _subscription?.cancel();
    isClosed = true;
    return super.close();
  }
}
