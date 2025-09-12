import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/app/router.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';

@RoutePage()
class AuthWrapperPage extends ConsumerWidget {
  const AuthWrapperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return AutoRouter.declarative(
      routes: (context) {
        return authState.when(
          data: (state) => [
            if (state.session?.user != null)
              const HealthEntriesRoute()
            else
              const SignInRoute(),
          ],
          loading: () => [const SplashRoute()],
          error: (e, s) => [const SignInRoute()],
        );
      },
    );
  }
}
