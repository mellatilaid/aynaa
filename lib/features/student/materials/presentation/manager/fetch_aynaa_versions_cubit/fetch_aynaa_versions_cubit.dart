import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/local_db_service/local_d_b_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/common/versions/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/common/versions/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final VersionsRepo materialsRepo;
  final LocalDbService isarStorageService;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchAynaaVersionsCubit(this.materialsRepo, this.isarStorageService)
      : super(FetchAynaaVersionsInitial()) {
    //_sync();
  }
  _sync() {
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
    final result = await materialsRepo.fetchVersions();
    result.fold(
        (failure) =>
            emit(FetchAynaaVersionsFailure(errMessage: failure.errMessage)),
        (aynaaVersions) {
      emit(
        FetchAynaaVersionsSucuss(
            aynaaVersions: aynaaVersions.reversed.toList()),
      );
      _stream();
    });
  }

  void _stream() {
    isarStorageService
        .watchAll<AynaaVersionsEntity>(collectionType: Entities.versions)
        .listen((versions) {
      if (isClosed) return;
      emit(
        FetchAynaaVersionsSucuss(aynaaVersions: versions.reversed.toList()),
      ); // Emit updated data
    });
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _subscription?.cancel();
    isClosed = true;
    return super.close();
  }
}
