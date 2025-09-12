import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/app/injection.dart';
import 'package:health_tracker/app/router.dart';
import 'package:health_tracker/core/theme/app_theme.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

class HealthTracker extends StatelessWidget {
  const HealthTracker({super.key});

  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouterConfig>();
    return OverlaySupport.global(
      child: AuthObserver(
        router: router,
        child: MaterialApp.router(
          title: 'Health Tracker',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: router.config(),
        ),
      ),
    );
  }
}

class AuthObserver extends ConsumerWidget {
  final Widget child;
  final AppRouterConfig router;
  const AuthObserver({super.key, required this.child, required this.router});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateChangesProvider, (previousState, nextState) async {
      final user = nextState.value?.session?.user;
      await Future.delayed(const Duration(milliseconds: 300));
      if (user != null) {
        router.replaceAll([const HealthEntriesRoute()]);
      } else {
        router.replaceAll([const SignInRoute()]);
      }
    });
    return child;
  }
}

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
