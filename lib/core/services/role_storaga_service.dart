// lib/core/local_storage/role_storage.dart
import 'dart:convert';

import 'package:atm_app/features/auth/data/models/user_model.dart';
import 'package:atm_app/features/auth/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ProfileStorage {
  Future<String?> getCachedRole();
  Future<void> cacheRole(String userRole);
  Future<UserEntity?> getCahcedProfile();
  Future<void> cachProfile(UserModel role);
  Future<void> clearCachedRole();
}

class SharedPrefsRoleStorage implements ProfileStorage {
  static const _userProfile = 'user_profile';
  static const _userRole = 'user_role';

  @override
  Future<String?> getCachedRole() async {
    final prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString(_userRole);

    if (userJson == null) return null;

    return userJson;
  }

  @override
  Future<void> cacheRole(String userRole) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_userRole, userRole);
  }

  @override
  Future<void> clearCachedRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userRole);
    await prefs.remove(_userProfile);
  }

  @override
  Future<void> cachProfile(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(UserModel.toMapStatic(userEntity: user));
    await prefs.setString(_userProfile, userJson);
  }

  @override
  Future<UserEntity?> getCahcedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString(_userProfile);

    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson));
  }
}
