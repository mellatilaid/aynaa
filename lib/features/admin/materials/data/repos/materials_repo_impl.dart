import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/storage_service.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repos/materials_repo.dart';

class MaterialsRepoImpl extends MaterialsRepo {
  final StorageService storageService;

  MaterialsRepoImpl({required this.storageService});
  @override
  Future<Either<Failures, List<String>>> fetchAynaaVersions() {
    // TODO: implement fetchAynaaVersions
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> setAynaaVersion(
      {required String versionName}) async {
    try {
      final String bucketId = await storageService.createBucket(versionName);
      return Right(bucketId);
    } catch (e) {
      return Left(ServerFailure(errMessage: e.toString()));
    }
  }
}
