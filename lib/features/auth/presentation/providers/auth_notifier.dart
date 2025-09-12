import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/app/injection.dart';
import 'package:health_tracker/core/widgets/app_snackbar.dart';
import 'package:health_tracker/features/auth/models/auth_state.dart';
import 'package:health_tracker/features/auth/repo/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthNotifier extends StateNotifier<AppAuthState> {
  final AuthRepository _authRepository = locator<AuthRepository>();

  AuthNotifier() : super(AppAuthState());

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loading: true);
    try {
      await _authRepository.signInWithEmail(email: email, password: password);
      state = state.copyWith(loading: false);
      AppSnackbar.success('Login successful');
    } on AuthException catch (e) {
      AppSnackbar.error(e.message);
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(loading: true);
    try {
      await _authRepository.signUpWithEmail(email: email, password: password);
      state = state.copyWith(loading: false);
      AppSnackbar.success(
        'Sign up successful. Please verify your email and login',
      );
    } on AuthException catch (e) {
      AppSnackbar.error(e.message);
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(googleLoading: true);
    try {
      await _authRepository.signInWithGoogle();
      AppSnackbar.success('Login successful');
    } on AuthException catch (e) {
      AppSnackbar.error(e.message);
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      state = state.copyWith(googleLoading: false);
    }
  }
}
