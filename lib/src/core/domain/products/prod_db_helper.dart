import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import 'products.dart';

class ProductDatabaseHelper {
  static final ProductDatabaseHelper _instance =
      ProductDatabaseHelper._internal();
  static Database? _database;

  factory ProductDatabaseHelper() {
    return _instance;
  }

  ProductDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'products.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productName TEXT,
        productBrand TEXT,
        price REAL,
        description TEXT,
        image TEXT,
        howToUse TEXT,
        ingredients TEXT,
        reviewCount INTEGER,
        productType TEXT,
        sizes TEXT
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    Database db = await database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAll() async {
    final db = await database;
    const orderBy = 'productName';
    final result = await db.query('products', orderBy: orderBy);
    return result.map((json) => Product.fromMap(json)).toList();
  }

  Future<List<Product>> getProducts() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<int> updateProduct(Product product) async {
    Database db = await database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
