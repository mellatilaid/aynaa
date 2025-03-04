import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthServices {
  Future<User> signInWithGoogle();
  Future<User> signInWithEmailAndPassword();
  Future<User> signInWithFacebook();
  Future<void> deleteUserFromAuth({required User user});
  Future<void> signOut();
  bool isLoggedIn();
}
