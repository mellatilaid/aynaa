import 'dart:async';
import 'dart:developer';

import 'package:atm_app/core/const/local_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/helper/name_encrypte.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/db_sync_service/I_db_sync_service.dart';
import 'package:atm_app/core/services/internt_state_service/i_network_state_service.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/common/versions/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/features/common/versions/data/data_source/versions_data_source/versions_remote_data_source.dart';
import 'package:atm_app/features/common/versions/data/models/aynaa_versions_model.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../../core/const/remote_db_const.dart';
import '../../../../../../core/helper/enums.dart';
import '../../domain/repos/versions_repo.dart';

class VersionsRepoImpl extends VersionsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final AynaaVersionsRemoteDataSource remoteDataSource;
  final VersionsLocalDataSource versionsLocalDataSource;
  final IDBSyncService dbSyncService;
  final INetworkStateService networkStateService;
  VersionsRepoImpl({
    required this.remoteDataSource,
    required this.dataBase,
    required this.storageService,
    required this.versionsLocalDataSource,
    required this.dbSyncService,
    required this.networkStateService,
  });
  @override
  Future<Either<Failures, List<AynaaVersionsEntity>>> fetchVersions() async {
    try {
      List<AynaaVersionsEntity> versions;
      versions = await versionsLocalDataSource.fetchVersion();

      if (versions.isNotEmpty) {
        // Return local versions immediately
        if (await networkStateService.isOnline()) {
          // Perform sync in the background without blocking
          unawaited(remoteDataSource.syncVersions());
        }

        return right(versions);
      } else if (versions.isNotEmpty) {
        return right(versions);
      }
      if (!await networkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
      versions = await remoteDataSource.fetchAynaaVersions();
      log('remote version ${versions.length}');
      return right(versions);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> setVersion(
      {required AynaaVersionsEntity version, required String filePath}) async {
    try {
      if (!await networkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
      final encryptedName = encrypteName(version.versionName);
      await storageService.createBucket(encryptedName);
      final model = AynaaVersionsModel.fromVersionEntity(version);
      final data = model.toMap();
      final fileName = path.basename(filePath);
      final fullPath = await storageService.uploadFile(
        bucketName: encryptedName,
        filePath: filePath,
        fileName: fileName,
      );
      data[kUrl] = fullPath;
      await dataBase.setDate(path: DbEnpoints.aynaaVersions, data: data);

      return const Right('');
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      storageService.deleteBucket(version.versionName);
      log(e.toString());
      return Left(ServerFailure.fromSupaDataBase(e: e));
    } on StorageException catch (e) {
      return Left(ServerFailure.fromStorage(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> saveVersion(
      {required AynaaVersionsEntity aynaaVersion}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> deleteVersion(
      {required AynaaVersionsEntity aynaaVersion}) async {
    try {
      //await storageService.emptyBucket(aynaaVersion.versionName);
      //await storageService.deleteBucket(aynaaVersion.versionName);
      if (!await networkStateService.isOnline()) {
        return left(ServerFailure(errMessage: kNoInternet));
      }
      dbSyncService.deleteInBauckground(
        [aynaaVersion],
        Entities.versions,
      );
      await dataBase.updateData(
        path: DbEnpoints.aynaaVersions,
        uid: aynaaVersion.entityID,
        data: {
          kIsDeleted: true,
        },
      );
      return const Right('');
    } on PostgrestException catch (e) {
      log(e.toString());

      return Left(ServerFailure.fromSupaDataBase(e: e));
    } on StorageException catch (e) {
      log(e.toString());
      return Left(ServerFailure.fromStorage(e: e));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
