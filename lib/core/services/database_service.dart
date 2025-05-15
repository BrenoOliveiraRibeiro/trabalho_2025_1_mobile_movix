import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;


class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'deliveries.db');


    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE deliveries (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description TEXT,
        status TEXT,
        date TEXT
      )
    ''');
  }

  Future<void> insertDelivery(String description, String status, String date) async {
    final db = await database;
    await db.insert('deliveries', {
      'description': description,
      'status': status,
      'date': date,
    });
  }

  Future<List<Map<String, dynamic>>> getDeliveries() async {
    final db = await database;
    return await db.query('deliveries', orderBy: 'date DESC');
  }
}
