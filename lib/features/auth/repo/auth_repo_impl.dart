import 'package:health_tracker/core/services/database_service.dart';
import 'package:health_tracker/features/auth/repo/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;
  final DatabaseService _dbService;

  AuthRepositoryImpl(this._supabaseClient, this._dbService);

  @override
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  @override
  String get avatarUrl =>
      'https://api.dicebear.com/8.x/initials/png?seed=${currentUser?.email ?? 'default'}';

  @override
  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // You can handle specific Supabase exceptions here for better UX
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    // This will be implemented in the next phase after UI is ready
    // as it requires platform-specific setup.
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    await _dbService.clearDatabase();
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }
}
