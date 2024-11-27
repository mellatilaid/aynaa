import 'package:atm_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class MaterialsRepo {
  Future<Either<Failures, List<String>>> fetchAynaaVersions();
  Future<Either<Failures, String>> setAynaaVersion(
      {required String versionName});
}
