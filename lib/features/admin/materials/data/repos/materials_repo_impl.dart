import 'dart:developer';

import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:atm_app/features/admin/materials/data/data_source/aynaa_versions_data_source.dart/aynaa_versions_remote_data_sourse.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repos/materials_repo.dart';

class MaterialsRepoImpl extends MaterialsRepo {
  final StorageService storageService;
  final AynaaVersionsRemoteDataSource remoteDataSource;

  MaterialsRepoImpl(this.remoteDataSource, {required this.storageService});
  @override
  Future<Either<Failures, List<AynaaVersionsEntity>>> fetchAynaaVersions(
      {required String versionID}) async {
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
      final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);
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
