// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;
  static const String tableName = 'health_entries';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'health.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id TEXT PRIMARY KEY,
        created_at TEXT NOT NULL,
        title TEXT NOT NULL,
        mood TEXT NOT NULL,
        synced INTEGER NOT NULL DEFAULT 0,
        user_id TEXT NOT NULL,
        note TEXT
      )
    ''');
  }


  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(tableName);
  }
}