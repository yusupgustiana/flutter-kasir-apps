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

import 'package:new_kasir_apps/data/model/request/order_request-model.dart';
import 'package:new_kasir_apps/data/model/respons/product_respons.dart';
import 'package:new_kasir_apps/presentation/home/models/item_order.dart';
import 'package:new_kasir_apps/presentation/order/models/order_model.dart';
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
      version: 2,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableProducts(Id INTEGER PRIMARY KEY AUTOINCREMENT, product_id INTEGER, name TEXT, category String, price INTEGER, image TEXT, stock INTEGER, is_best_seller INTEGER, is_sync DEFAULT 0)');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nominal INTEGER,
        payment_method TEXT,
        total_item INTEGER,
        id_kasir INTEGER,
        nama_kasir TEXT,
        transaction_time TEXT,
        is_sync INTEGER DEFAULT 0
      )
    ''');
    await db.execute('''
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        id_order INTEGER,
        id_product INTEGER,
        quantity INTEGER,
        price INTEGER
      )
    ''');
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('produasc.db');
    return _database!;
  }

  Future<int> saveOrder(OrderModel order) async {
    final db = await instance.database;
    int id = await db.insert('orders', order.toMapForLocal());
    for (var orderItem in order.orders) {
      await db.insert('order_items', orderItem.toMapForLocal(id));
    }
    return id;
  }

  Future<List<OrderModel>> getOrderByIsSync() async {
    final db = await instance.database;
    final result = await db.query('orders', where: 'is_sync = 0');

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }

  //get order item by order local
  Future<List<OrderItemModel>> getOrderItemByOrderIdLocal(int idOrder) async {
    final db = await instance.database;
    final result = await db.query('order_items', where: 'id_order = $idOrder');

    return result.map((e) => OrderItem.fromMapLocal(e)).toList();
  }

  //server
  Future<List<OrderItem>> getOrderItemByOrderId(int idOrder) async {
    final db = await instance.database;
    final result = await db.query('order_items', where: 'id_order = $idOrder');

    return result.map((e) => OrderItem.fromMap(e)).toList();
  }

  //update isSync order by id
  Future<int> updateIsSyncOrderById(int id) async {
    final db = await instance.database;
    return await db.update('orders', {'is_sync': 1},
        where: 'id = ?', whereArgs: [id]);
  }

  //remove all data product
  Future<void> removeAllProduct() async {
    final db = await instance.database;
    await db.delete(tableProducts);
  }

//insert all product
  Future<void> insertAllProduct(List<Product> product) async {
    final db = await instance.database;
    for (var product in product) {
      await db.insert(tableProducts, product.toLocalMap());
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

  //get all orders
  Future<List<OrderModel>> getAllOrders() async {
    final db = await instance.database;
    final result = await db.query('orders', orderBy: 'id DESC');

    return result.map((e) => OrderModel.fromLocalMap(e)).toList();
  }
}
