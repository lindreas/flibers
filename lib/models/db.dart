import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE tricks(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name TEXT,
        level INTEGER,
        category TEXT,
        flat_ground INTEGER
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'flibers_database.db',
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (trick)
  static Future<int> createItem(
      String name, int? level, String? category, int? flatGround) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'level': level,
      'category': category,
      'flat_ground': flatGround
    };
    final id = await db.insert('tricks', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (tricks)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('tricks', orderBy: "name");
  }

  // Get tricks by diffictulty level
  static Future<List<Map<String, dynamic>>> getRandom(String? level) async {
    final db = await SQLHelper.db();
    var inArgs = [];

    switch (level) {
      case "Easy":
        inArgs.add(1);
        break;
      case "Medium":
        inArgs.addAll([1, 2]);
        break;
      case "Hard":
        inArgs.addAll([1, 2, 3]);
        break;
      default:
    }
    return db.query('tricks',
        where: 'level IN (${List.filled(inArgs.length, '?').join(',')})',
        whereArgs: inArgs);
  }

  // Update an item by id
  static Future<int> updateItem(int id, String name, int? level,
      String? category, int? flatGround) async {
    final db = await SQLHelper.db();

    final data = {
      'name': name,
      'level': level,
      'category': category,
      'flat_ground': flatGround
    };

    final result =
        await db.update('tricks', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("tricks", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting a trick: $err");
    }
  }
}
