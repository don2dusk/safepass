import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'safepass.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE user (
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        masterPasswordHash TEXT,
        kek_salt TEXT,
        encrypted_password_key TEXT
      )
      ''');
    await db.execute('''
      CREATE TABLE passwordEntry (
        entryId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        title TEXT,
        favicon TEXT,
        website TEXT,
        username TEXT,
        password TEXT,
        description TEXT,
        createdDate TEXT,
        category TEXT,
        modifiedDate TEXT,
        FOREIGN KEY (userId) REFERENCES user(userId)
      )
      ''');
  }
}
