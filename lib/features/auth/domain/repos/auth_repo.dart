import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failures, UserEntity>> signInWithGoogle();
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword();
  Future<Either<Failures, UserEntity>> signInWithFacebook();
  bool isLoggedIn();
}
