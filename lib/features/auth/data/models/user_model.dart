import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/const/remote_db_const.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.uid,
      required super.name,
      required super.email,
      required super.role});

  factory UserModel.fromSupabase(User user) {
    return UserModel(
      uid: user.id,
      name: user.userMetadata?['name'],
      email: user.email ?? '',
      role: user.role ?? '',
    );
  }

  factory UserModel.fromJson(json) {
    return UserModel(
        uid: json[kUuid],
        name: json[kUserName],
        email: json[kUserEmail],
        role: json[kUserRole]);
  }

  toMap() {
    return {kUuid: uid, kUserName: name, kUserEmail: email, kUserRole: role};
  }

  static Map<String, dynamic> toMapStatic({required UserEntity userEntity}) {
    return {
      kUuid: userEntity.uid,
      kUserName: userEntity.name,
      kUserEmail: userEntity.email,
      kUserRole: userEntity.role,
    };
  }
}
