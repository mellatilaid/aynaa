import 'dart:developer';

import 'package:atm_app/const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/aynaa_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repos/versions_repo.dart';

class VersionsRepoImpl extends VersionsRepo {
  final DataBase dataBase;
  final StorageService storageService;
  final AynaaVersionsRemoteDataSource remoteDataSource;

  VersionsRepoImpl(this.remoteDataSource,
      {required this.dataBase, required this.storageService});
  @override
  Future<Either<Failures, List<AynaaVersionsEntity>>>
      fetchAynaaVersions() async {
    try {
      final List<AynaaVersionsEntity> aynaaVersions =
          await remoteDataSource.fetchAynaaVersions();
      return right(aynaaVersions);
    } catch (e) {
      return left(ServerFailure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failures, String>> setAynaaVersion(
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
  Future<Either<Failures, String>> saveAynaaVersion(
      {required AynaaVersionsEntity aynaaVersion}) {
    throw UnimplementedError();
  }
}
