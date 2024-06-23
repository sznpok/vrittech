import 'package:sqflite/sqflite.dart';

import '../model/image_data_model.dart';

class DatabaseHelper {
  static const _databaseName = 'image.db';
  static const _tableName = 'image';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = '$dbPath/$_databaseName';

    final database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          base64Image TEXT NOT NULL
        )
      ''');
    });
    return database;
  }

  Future<void> saveImage(String base64Image) async {
    final db = await database;
    await db.delete(_tableName);
    await db.insert(
        _tableName, ImageData(id: 0, base64Image: base64Image).toMap());
  }

  Future<ImageData?> getImage() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    if (maps.isNotEmpty) {
      return ImageData.fromMap(maps.first);
    }
    return null;
  }
}
