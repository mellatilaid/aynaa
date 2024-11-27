import 'package:atm_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AynaaVersionsRepo {
  Future<Either<Failures, List<String>>> fetchAynaaVersions();
  Future<Either<Failures, void>> setAynaaVersion();
}
