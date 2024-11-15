import 'package:atm_app/const.dart';
import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        uid: json[kUserID],
        name: json[kUserName],
        email: json[kUserEmail],
        role: json[kUserRole]);
  }

  toMap() {
    return {kUserID: uid, kUserName: name, kUserEmail: email, kUserRole: role};
  }
}
