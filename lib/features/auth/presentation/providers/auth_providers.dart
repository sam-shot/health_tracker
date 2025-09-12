import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/app/injection.dart';
import 'package:health_tracker/features/auth/models/auth_state.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_notifier.dart';
import 'package:health_tracker/features/auth/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provider for the AuthRepository implementation.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return locator<AuthRepository>();
});

/// This provider exposes a stream of the user's authentication state.
final authStateChangesProvider = StreamProvider<AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

/// This provider manages the state for the auth UI (e.g., loading spinners,
/// error messages). It is controlled by the [AuthNotifier].
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AppAuthState>((_) {
  return AuthNotifier();
});
