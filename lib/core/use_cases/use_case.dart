import 'package:atm_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failures, Type>> call(Param param);
}

class NoParam {}
