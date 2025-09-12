import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/app/injection.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_state.dart';
import 'package:health_tracker/features/health_entry/presentation/providers/health_entry_notifier.dart';
import 'package:health_tracker/features/health_entry/repo/health_entry_repo.dart';

/// Provider that acts as a bridge to expose the [HealthEntryRepository]
final healthEntryRepositoryProvider = Provider<HealthEntryRepository>((ref) {
  return locator<HealthEntryRepository>();
});

/// The main provider for UI.
/// It provides the [HealthEntryNotifier] and its state [HealthEntryState].
final healthEntryNotifierProvider =
    StateNotifierProvider<HealthEntryNotifier, HealthEntryState>((ref) {
  final repository = ref.watch(healthEntryRepositoryProvider);
  return HealthEntryNotifier(repository,ref);
});
