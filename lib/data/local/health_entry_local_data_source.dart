import 'package:health_tracker/core/services/database_service.dart';
import 'package:health_tracker/features/health_entry/models/health_entry_model.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

abstract class HealthEntryLocalDataSource {
  /// Fetches all entries for the current user from Local Storage .
  Future<List<HealthEntry>> getHealthEntries();

  /// Saves a single entry to Local Storage.
  Future<void> saveHealthEntry(HealthEntry entry);

  /// Fetches all unsynced entries for the current user from Local Storage.
  Future<List<HealthEntry>> getUnsyncedHealthEntries();
}

@LazySingleton(as: HealthEntryLocalDataSource)
class HealthEntryLocalDataSourceImpl implements HealthEntryLocalDataSource {
  final DatabaseService _dbService;

  HealthEntryLocalDataSourceImpl(this._dbService);

  @override
  Future<List<HealthEntry>> getHealthEntries() async {
    final db = await _dbService.database;
    
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseService.tableName,
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return HealthEntry.fromJson(maps[i]);
    });
  }

  @override
  Future<void> saveHealthEntry(HealthEntry entry) async {
    final db = await _dbService.database;
    await db.insert(
      DatabaseService.tableName,
      entry.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<HealthEntry>> getUnsyncedHealthEntries() async {
    final db = await _dbService.database;
    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseService.tableName,
      where: 'synced = ?',
      whereArgs: [0],
    );
    return List.generate(maps.length, (i) => HealthEntry.fromJson(maps[i]));
  }
}
