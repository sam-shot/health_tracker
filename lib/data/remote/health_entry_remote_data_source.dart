import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class HealthEntryRemoteDataSource {
  /// Fetches all entries for the current user from Supabase.
  Future<List<HealthEntry>> getHealthEntries();

  /// Saves a single entry to Supabase.
  Future<void> saveHealthEntry(HealthEntry entry);
}

@LazySingleton(as: HealthEntryRemoteDataSource)
class HealthEntryRemoteDataSourceImpl implements HealthEntryRemoteDataSource {
  final SupabaseClient _supabaseClient;

  HealthEntryRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<List<HealthEntry>> getHealthEntries() async {
    try {
      final data = await _supabaseClient
          .from('health_entries')
          .select()
          .order('created_at', ascending: false);

      final entries = data.map((item) => HealthEntry.fromJson(item)).toList();
      return entries;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveHealthEntry(HealthEntry entry) async {
    try {
      final entryMap = entry.toJson();
      entryMap.remove('synced');
      await _supabaseClient.from('health_entries').upsert(entryMap);
    } catch (e) {
      rethrow;
    }
  }
}
