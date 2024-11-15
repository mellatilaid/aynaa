import 'package:atm_app/core/services/auth_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService extends AuthServices {
  final _supabase = Supabase.instance.client;
  @override
  Future<User> signInWithEmailAndPassword() {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithGoogle() async {
    final webClientId = dotenv.get('web_CLIENT_ID');
    const iosClientId = 'my-ios.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );

    await googleSignIn.signOut();

    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser?.authentication;

    final idToken = googleAuth?.idToken;
    final accessToken = googleAuth?.accessToken;

    if (idToken == null || accessToken == null) {
      throw 'Google Sign-In failed: No ID or Access Token found.';
    }

    // Authenticate with Supabase using the ID and Access Tokens
    final authResponse = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    return authResponse.user!;
  }

  @override
  Future<void> deleteUserFromAuth({required User user}) async {}

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    await _supabase.auth.signOut();
  }
}
