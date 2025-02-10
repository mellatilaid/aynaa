import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/services/isar_storage_service.dart';
import 'package:atm_app/core/utils/set_up_service_locator.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/features/admin/materials/domain/repos/versions_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final VersionsRepo materialsRepo;
  final IsarStorageService isarStorageService;
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
        .watchAll<AynaaVersionsEntity>(collectionType: CollentionType.versions)
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
