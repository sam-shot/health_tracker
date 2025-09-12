import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_tracker/core/widgets/app_snackbar.dart';
import 'package:health_tracker/features/auth/presentation/providers/auth_providers.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_state.dart';
import 'package:health_tracker/features/health_entry/repo/health_entry_repo.dart';
import 'package:uuid/uuid.dart';

class HealthEntryNotifier extends StateNotifier<HealthEntryState> {
  final HealthEntryRepository _repository;
  final Ref _ref;

  HealthEntryNotifier(this._repository, this._ref)
      : super(const HealthEntryState());

  /// Fetches all health entries and updates the state.
  Future<void> getEntries() async {
    state = state.copyWith(
      isLoading: true,
    );
    try {
      final entries = await _repository.getHealthEntries();
      entries.sort(
        (a, b) => b.createdAt.toLocal().compareTo(a.createdAt.toLocal()),
      );
      state = state.copyWith(entries: entries);
    } catch (e) {
      AppSnackbar.error('Failed to load health entries.');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  /// Adds a new health entry and then refreshes the list.
  Future<bool> addEntry({
    required Mood mood,
    required String title,
    String? note,
  }) async {
    state = state.copyWith(
      savingEntry: true,
    );
    try {
      HealthEntry entry = HealthEntry(
        id: const Uuid().v4(),
        title: title,
        mood: mood,
        note: note,
        userId: _ref.read(authRepositoryProvider).currentUser?.id ?? '',
        createdAt: DateTime.now().toLocal(),
        isSynced: false,
      );

      await _repository.saveHealthEntry(
        entry: entry,
        onRemoteSave: () {
          entry = entry.copyWith(isSynced: true);
        },
      );
      state = state.copyWith(
        entries: [
          entry,
          ...state.entries,
        ],
      );

      AppSnackbar.success('Health entry saved successfully.');
      return true;
    } catch (e) {
      AppSnackbar.error('Failed to save health entry. $e');
      return false;
    } finally {
      state = state.copyWith(savingEntry: false);
    }
  }
}
