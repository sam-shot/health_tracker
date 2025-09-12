import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  /// Stream of authentication state changes.
  Stream<AuthState> get authStateChanges;

  /// Get the current user, if any.
  User? get currentUser;

  /// Get User avatar
  String get avatarUrl;

  /// Sign up with email and password.
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Sign in with email and password.
  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  /// Sign in with Google.
  Future<void> signInWithGoogle();

  /// Sign out the current user.
  Future<void> signOut();
}
