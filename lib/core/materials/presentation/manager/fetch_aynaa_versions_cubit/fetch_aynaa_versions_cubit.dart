import 'dart:async';

import 'package:atm_app/core/helper/enums.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/materials/domain/repos/versions_repo.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/local_db_service/i_local_db_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_aynaa_versions_state.dart';

class FetchAynaaVersionsCubit extends Cubit<FetchAynaaVersionsState> {
  final VersionsRepo materialsRepo;
  final ILocalDbService iLocalDbService;
  final INetworkStateService networkStateService;
  StreamSubscription? _subscription;
  @override
  bool isClosed = false;
  FetchAynaaVersionsCubit({
    required this.materialsRepo,
    required this.iLocalDbService,
    required this.networkStateService,
  }) : super(FetchAynaaVersionsInitial()) {
    //_sync();
  }
  /* _sync() {
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
  }*/

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
    iLocalDbService
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
