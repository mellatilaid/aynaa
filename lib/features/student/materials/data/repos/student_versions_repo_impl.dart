import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_local_data_source.dart';
import 'package:atm_app/core/materials/data/data_source/versions_data_source/versions_remote_data_source.dart';
import 'package:atm_app/core/materials/data/models/aynaa_versions_model.dart';
import 'package:atm_app/core/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:dartz/dartz.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/helper/enums.dart';
import '../../../../../core/materials/domain/repos/versions_repo.dart';
import '../../../../../core/services/storage_sync_service/storage_sync_service.dart';

class StudentVersionsRepoImpl extends VersionsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final AynaaVersionsRemoteDataSource remoteDataSource;
  final VersionsLocalDataSource versionsLocalDataSource;
  final StorageSyncService backgroundServices;
  StudentVersionsRepoImpl({
    required this.remoteDataSource,
    required this.dataBase,
    required this.storageService,
    required this.versionsLocalDataSource,
    required this.backgroundServices,
  });
  @override
  Future<Either<Failures, List<AynaaVersionsEntity>>> fetchVersions() async {
    try {
      final List<AynaaVersionsEntity> localVersions =
          await versionsLocalDataSource.fetchVersion();
      log(localVersions.length.toString());
      if (localVersions.isNotEmpty) {
        return right(localVersions);
      }
      final List<AynaaVersionsEntity> remoteVersions =
          await remoteDataSource.fetchAynaaVersions();
      log('remote version ${remoteVersions.length}');
      return right(remoteVersions);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> setVersion(
      {required AynaaVersionsEntity version, required String filePath}) async {
    try {
      await storageService.createBucket(version.versionName);
      final model = AynaaVersionsModel.fromVersionEntity(version);
      final data = model.toMap();
      final fileName = path.basename(filePath);
      final fullPath = await storageService.uploadFile(
        bucketName: version.versionName,
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
      backgroundServices.deleteItemFile(
        item: aynaaVersion,
        deletedItemType: DeletedItemType.version,
      );
      await dataBase.deleteData(
        path: DbEnpoints.aynaaVersions,
        uid: aynaaVersion.entityID,
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
