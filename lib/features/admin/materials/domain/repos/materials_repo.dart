import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/admin/materials/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MaterialsRepo {
  Future<Either<Failures, List<AynaaVersionsEntity>>> fetchAynaaVersions();
  Future<Either<Failures, String>> setAynaaVersion(
      {required String versionName});
  Future<Either<Failures, String>> saveAynaaVersion(
      {required AynaaVersionsEntity aynaaVersion});
}
