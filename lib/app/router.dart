import 'package:auto_route/auto_route.dart';
import 'package:health_tracker/app/app.dart';
import 'package:health_tracker/features/auth/presentation/pages/auth_wrapper.dart';
import 'package:health_tracker/features/auth/presentation/pages/sign_in.dart';
import 'package:health_tracker/features/auth/presentation/pages/sign_up.dart';
import 'package:health_tracker/features/health_entry/presentation/pages/create_entry_page.dart';
import 'package:health_tracker/features/health_entry/presentation/pages/health_entries_page.dart';
import 'package:health_tracker/features/profile/presentation/pages/profile_page.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@LazySingleton()
class AppRouterConfig extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: HealthEntriesRoute.page,
        ),
        AutoRoute(
          page: CreateEntryRoute.page,
        ),
        AutoRoute(
          page: ProfileRoute.page,
        ),

        /// Auth routes - SignIn and SignUp
        AutoRoute(
          page: SignInRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
      ];
}
