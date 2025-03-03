// lib/core/local_storage/role_storage.dart
import 'dart:convert';

import 'package:atm_app/core/const/remote_db_const.dart';
import 'package:atm_app/core/helper/user_profile.dart';
import 'package:atm_app/features/auth/data/models/user_model.dart';
import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileStorage {
  Future<String?> getCachedRole();
  Future<void> cacheRole(String userRole);
  Future<UserEntity?> loadUserProfile();
  Future<void> cachProfile(UserModel role);
  Future<void> clearCacheProfile();
  UserEntity? get userProfile;
}

class ProfileStorageImpl implements ProfileStorage {
  static const _userProfile = 'user_profile';
  static const _userRole = 'user_role';
  UserEntity? _user;
  static String userRole = kStudentRole;
  @override
  UserEntity? get userProfile => _user;

  void setUserRole(UserEntity role) {
    _user = role;
  }

  @override
  Future<String?> getCachedRole() async {
    final prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString(_userRole);

    if (userJson == null) return null;
    globalUserRole = userJson;
    return userJson;
  }

  @override
  Future<void> cacheRole(String userRole) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userRole, userRole);
  }

  @override
  Future<void> clearCacheProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRole);
    await prefs.remove(_userProfile);
  }

  @override
  Future<void> cachProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(UserModel.toMapStatic(userEntity: user));
    _user = user;
    userRole = user.role;
    globalUserRole = user.role;

    await prefs.setString(_userProfile, userJson);
  }

  @override
  Future<UserEntity?> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString(_userProfile);

    if (userJson == null) return null;
    globalUserRole = jsonDecode(userJson)['role'];
    _user = UserModel.fromJson(jsonDecode(userJson));
    return UserModel.fromJson(jsonDecode(userJson));
  }
}
