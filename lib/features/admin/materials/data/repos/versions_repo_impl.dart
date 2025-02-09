import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/aynaa_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/versions_local_data_source.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/const/remote_db_const.dart';
import '../../../../../core/helper/enums.dart';
import '../../../../../core/services/background_services.dart';
import '../../domain/repos/versions_repo.dart';

class VersionsRepoImpl extends VersionsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final AynaaVersionsRemoteDataSource remoteDataSource;
  final VersionsLocalDataSource versionsLocalDataSource;
  final BackgroundServices backgroundServices;
  VersionsRepoImpl({
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
      {required String versionName}) async {
    try {
      await storageService.createBucket(versionName);
      await dataBase.setDate(
          path: DbEnpoints.aynaaVersions, data: {kVersionName: versionName});

      return const Right('');
      /*final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);*/
    } on PostgrestException catch (e) {
      storageService.deleteBucket(versionName);
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
