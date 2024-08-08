import 'package:skincare_app/src/core/domain/shipping_info/shipping_info.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._internal();

  static Database? _database;
  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/notes.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
CREATE TABLE shippinginfo (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT NOT NULL,
phoneNumber INTEGER NOT NULL,
streetAddress TEXT NOT NULL,
houseNo INTEGER NOT NULL,
postCode INTEGER,

)

''');
  }

  Future<ShippingInfo> create(ShippingInfo ship) async {
    final db = await instance.database;
    final id = await db.insert('shippinginfo', ship.toMap());
    return ship.copy(id: id);
  }

  Future<ShippingInfo> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'shippinginfo',
      where: '$id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ShippingInfo.fromJson(maps.first);
    } else {
      throw Exception('ID');
    }
  }

  Future<List<ShippingInfo>> readAll() async {
    final db = await instance.database;
    final result = await db.query('shippinginfo');
    return result.map((json) => ShippingInfo.fromJson(json)).toList();
  }

  Future<int> update(ShippingInfo ship) async {
    final db = await instance.database;
    return db.update(
      'shippinginfo',
      ship.toMap(),
      where: 'id = ?',
      whereArgs: [
        ship.id,
      ],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'shippinginfo',
      where: 'id = ?',
      whereArgs: [
        id,
      ],
    );
  }

  Future closeDb() async {
    final db = await instance.database;
    db.close();
  }
}
