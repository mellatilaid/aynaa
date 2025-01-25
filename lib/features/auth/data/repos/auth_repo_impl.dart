import 'dart:developer';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/errors/failures.dart';
import 'package:atm_app/core/services/auth_services.dart';
import 'package:atm_app/core/services/data_base.dart';
import 'package:atm_app/core/utils/db_enpoints.dart';
import 'package:atm_app/features/auth/data/models/user_model.dart';
import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:atm_app/features/auth/domain/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthServices authServices;
  final DataBase dataBase;

  AuthRepoImpl({required this.authServices, required this.dataBase});
  @override
  Future<Either<Failures, UserEntity>> signInWithEmailAndPassword() {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, UserEntity>> signInWithGoogle() async {
    User user;

    try {
      user = await authServices.signInWithGoogle();
      log(user.id.toString());
      var userEntity = UserModel.fromSupabase(user);

      bool doesUserExists = await dataBase.checkIfUserExistInDB(
          path: DbEnpoints.users, uID: user.id);
      if (doesUserExists) {
        final Map<String, dynamic> userData = await dataBase.getData(
          path: DbEnpoints.users,
          uID: user.id,
        );
        userEntity = UserModel.fromJson(userData);
        return right(userEntity);
      } else {
        userEntity.role = kStudentRole;
        await dataBase.setDate(
            path: DbEnpoints.users, data: userEntity.toMap());
        return right(userEntity);
      }
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(errMessage: e.toString()));
    }
  }
}
