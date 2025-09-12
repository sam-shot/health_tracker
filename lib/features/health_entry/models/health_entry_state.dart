import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';

class HealthEntryState {
  final List<HealthEntry> entries;
  final bool isLoading;
  final bool savingEntry;
  final String? errorMessage;

  const HealthEntryState({
    this.entries = const [],
    this.isLoading = false,
    this.savingEntry = false,
    this.errorMessage,
  });

  HealthEntryState copyWith({
    List<HealthEntry>? entries,
    bool? isLoading,
    bool? savingEntry,
    Object? errorMessage = _sentinel,
  }) {
    return HealthEntryState(
      entries: entries ?? this.entries,
      isLoading: isLoading ?? this.isLoading,
      savingEntry: savingEntry ?? this.savingEntry,
      errorMessage: identical(errorMessage, _sentinel)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }
}

const _sentinel = Object();
