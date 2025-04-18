import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/common/versions/domain/entities/aynaa_versions_entity.dart';
import 'package:dartz/dartz.dart';

abstract class VersionsRepo {
  Future<Either<Failures, List<AynaaVersionsEntity>>> fetchVersions();
  Future<Either<Failures, String>> setVersion(
      {required AynaaVersionsEntity version, required String filePath});
  Future<Either<Failures, String>> saveVersion(
      {required AynaaVersionsEntity aynaaVersion});
  Future<Either<Failures, String>> deleteVersion(
      {required AynaaVersionsEntity aynaaVersion});
}
