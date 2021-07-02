import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shopping_list/widgets/ListItem.dart';
import 'widgets/ShoppingList.dart';
import 'models/list_data.dart';
import 'dart:collection';

class DbHelper {
  static Database? _db;
  static Database? _db2;

  static Future<Database> _getDb() async {
    if (_db == null) {
      _db = await openDatabase(
        join(await getDatabasesPath(), 'shoppingList.db'),
        version: 1,
        onCreate: (db, version) async {
          await db.execute('CREATE TABLE shoppingLists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)');
          await db.execute('CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity INTEGER, note TEXT)');
        },
      );
      print('database shoppingLists.db is opened');
    }
    return _db!;
  }

  static Future<Database> _getDb2() async {
    if (_db2 == null) {
      _db2 = await openDatabase(
        join(await getDatabasesPath(), 'items.db'),
        version: 1,
        onCreate: (db, version) async {
          return await db.execute(
              'CREATE TABLE items(id INTEGER PRIMARY KEY, idList INTEGER, name TEXT, quantity INTEGER, note TEXT)');
        },
      );
      print('database items.db is opened');
    }
    return _db2!;
  }

  static Future<ShoppingList> insertShoppingList(ShoppingList shoppingList) async {
    Database db = await _getDb();
    shoppingList.id = await db.insert('shoppingLists', shoppingList.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return shoppingList;
  }

  static Future<int> deleteShoppingList(int id) async {
    Database db = await _getDb();
    return await db.delete('shoppingLists', where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateShoppingList(ShoppingList shoppingList) async {
    Database db = await _getDb();
    return await db.update('shoppingLists', shoppingList.toMap(),
        where: 'id = ?', whereArgs: [shoppingList.id]);
  }

  static Future<List<ShoppingList>> getAllShoppingLists() async {
    Database db = await _getDb();
    final List<Map<String, dynamic>> maps = await db.query('shoppingLists');
    print('Read ${maps.length} tasks from the database');
    return List.generate(
        maps.length,
            (i) => ShoppingList(
            id: maps[i]['id'],
            name: maps[i]['taskName'],
            priority: maps[i]['priority']),
    );
  }

  // static Future<ListItem> insertListItem(ListItem listItem) async {
  //   Database db = await _getDb();
  //   listItem.id = await db.insert('items', listItem.toMap(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  //   return listItem;
  // }
  //
  // static Future<int> deleteShoppingList(int id) async {
  //   Database db = await _getDb();
  //   return await db.delete('shoppingLists', where: 'id = ?', whereArgs: [id]);
  // }
  //
  // static Future<int> updateShoppingList(ShoppingList shoppingList) async {
  //   Database db = await _getDb();
  //   return await db.update('shoppingLists', shoppingList.toMap(),
  //       where: 'id = ?', whereArgs: [shoppingList.id]);
  // }
  //
  // static Future<List<ShoppingList>> getAllShoppingLists() async {
  //   Database db = await _getDb();
  //   final List<Map<String, dynamic>> maps = await db.query('shoppingLists');
  //   print('Read ${maps.length} tasks from the database');
  //   return List.generate(
  //     maps.length,
  //         (i) => ShoppingList(
  //         id: maps[i]['id'],
  //         name: maps[i]['taskName'],
  //         priority: maps[i]['priority'],
  //         items: []),
  //   );
  // }
}
