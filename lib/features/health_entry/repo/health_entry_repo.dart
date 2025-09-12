import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:health_tracker/data/local/health_entry_local_data_source.dart';
import 'package:health_tracker/data/remote/health_entry_remote_data_source.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:injectable/injectable.dart';

abstract class HealthEntryRepository {
  Future<List<HealthEntry>> getHealthEntries();
  Future<void> saveHealthEntry({
    required HealthEntry entry,
    Function()? onRemoteSave,
  });
}

@LazySingleton(as: HealthEntryRepository)
class HealthEntryRepositoryImpl implements HealthEntryRepository {
  final HealthEntryLocalDataSource _localDataSource;
  final HealthEntryRemoteDataSource _remoteDataSource;
  final Connectivity _connectivity;

  HealthEntryRepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
    this._connectivity,
  );

  @override
  Future<List<HealthEntry>> getHealthEntries() async {
    final localEntries = await _localDataSource.getHealthEntries();
    final hasConnection =
        (await _connectivity.checkConnectivity()) != ConnectivityResult.none;

    if (hasConnection) {
      try {
        await _syncLocalEntriesToRemote();
        final remoteEntries = await _remoteDataSource.getHealthEntries();

        for (final entry in remoteEntries) {
          await _localDataSource.saveHealthEntry(
            entry.copyWith(isSynced: true),
          );
        }

        return remoteEntries;
      } catch (e) {
        return localEntries;
      }
    } else {
      return localEntries;
    }
  }

  @override
  Future<void> saveHealthEntry({
    required HealthEntry entry,
    Function()? onRemoteSave,
  }) async {
    await _localDataSource.saveHealthEntry(entry);

    final hasConnection =
        (await _connectivity.checkConnectivity()) != ConnectivityResult.none;

    if (hasConnection) {
      try {
        await _syncLocalEntriesToRemote();
        onRemoteSave?.call();
      } catch (_) {}
    }
  }

  Future<void> _syncLocalEntriesToRemote() async {
    final unsyncedEntries = await _localDataSource.getUnsyncedHealthEntries();

    if (unsyncedEntries.isEmpty) return;

    for (final entry in unsyncedEntries) {
      await _remoteDataSource.saveHealthEntry(entry);
      await _localDataSource.saveHealthEntry(entry.copyWith(isSynced: true));
    }
  }
}
