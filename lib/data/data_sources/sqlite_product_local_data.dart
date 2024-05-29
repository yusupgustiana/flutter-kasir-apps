// import 'package:flutter_kasir_apps_frontend/data/model/respons/product_respons.dart';
// import 'package:sqflite/sqflite.dart';

// class ProductLocalData {
//   ProductLocalData._init();

//   static final ProductLocalData instance = ProductLocalData._init();
//   final String tableProducts = 'products';
//   static Database? _database;

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = dbPath + filePath;

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute(
//         'CREATE TABLE $tableProducts(Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category String, price INTEGER, image TEXT, stock INTEGER,best_seller INTEGER,is_sync INTEGER)');
//   }

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('product.db');
//     return _database!;
//   }

//   //remove all data product
//   Future<void> deleteAllProduct() async {
//     final db = await instance.database;
//     await db.delete(tableProducts);
//   }

// //insert product
//   Future<void> insertProduct(List<Product> product) async {
//     final db = await instance.database;
//     for (var product in product) {
//       await db.insert(tableProducts, product.toMap());
//     }
//   }

//   Future<List<Product>> getAllProducts() async {
//     final db = await instance.database;
//     final result = await db.query(tableProducts);
//     return result.map((e) => Product.fromMap(e)).toList();
//   }
// }


import 'package:new_kasir_apps/data/model/respons/product_respons.dart';
import 'package:sqflite/sqflite.dart';

class ProductLocalData {
  ProductLocalData._init();

  static final ProductLocalData instance = ProductLocalData._init();
  final String tableProducts = 'products';
  static Database? _database;

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableProducts(Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, category String, price INTEGER, image TEXT, stock INTEGER, is_best_seller INTEGER)');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('product3.db');
    return _database!;
  }

  //remove all data product
  Future<void> deleteAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProducts);
  }

//insert all product
  Future<void> insertAllProduct(List<Product> product) async {
    final db = await instance.database;
    for (var product in product) {
      await db.insert(tableProducts, product.toMap());
    }
  }

  //insert product
  Future<Product> insertProduct(Product product) async {
    final db = await instance.database;
    int id = await db.insert(tableProducts, product.toMap());
    return product.copyWith(id: id);
  }

//get all data product
  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query(tableProducts);
    return result.map((e) => Product.fromMap(e)).toList();
  }
}
