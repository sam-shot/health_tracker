// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../core/services/database_service.dart' as _i162;
import '../data/local/health_entry_local_data_source.dart' as _i471;
import '../data/remote/health_entry_remote_data_source.dart' as _i261;
import '../features/auth/repo/auth_repo.dart' as _i820;
import '../features/auth/repo/auth_repo_impl.dart' as _i885;
import '../features/health_entry/repo/health_entry_repo.dart' as _i358;
import 'injection.dart' as _i464;
import 'router.dart' as _i216;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i454.SupabaseClient>(() => registerModule.supabaseClient);
  gh.lazySingleton<_i162.DatabaseService>(() => registerModule.databaseService);
  gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i216.AppRouterConfig>(() => _i216.AppRouterConfig());
  gh.lazySingleton<_i820.AuthRepository>(() => _i885.AuthRepositoryImpl(
        gh<_i454.SupabaseClient>(),
        gh<_i162.DatabaseService>(),
      ));
  gh.lazySingleton<_i471.HealthEntryLocalDataSource>(
      () => _i471.HealthEntryLocalDataSourceImpl(gh<_i162.DatabaseService>()));
  gh.lazySingleton<_i261.HealthEntryRemoteDataSource>(
      () => _i261.HealthEntryRemoteDataSourceImpl(gh<_i454.SupabaseClient>()));
  gh.lazySingleton<_i358.HealthEntryRepository>(
      () => _i358.HealthEntryRepositoryImpl(
            gh<_i471.HealthEntryLocalDataSource>(),
            gh<_i261.HealthEntryRemoteDataSource>(),
            gh<_i895.Connectivity>(),
          ));
  return getIt;
}

class _$RegisterModule extends _i464.RegisterModule {}
