import 'dart:async';
import 'dart:ffi';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  //maby not async here
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'flibers.db'),
  );

  Future<List<Trick>> tricks() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('tricks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Trick(
        id: maps[i]['id'],
        name: maps[i]['name'],
        level: maps[i]['level'],
        category: maps[i]['category'],
        flatGround: maps[i]['flatGround'],
      );
    });
  }

  print(await tricks());
}

class Trick {
  final int id;
  final String name;
  final int level;
  final String category;
  final Bool flatGround;

  Trick({
    required this.id,
    required this.name,
    required this.level,
    required this.category,
    required this.flatGround,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'category': category,
      'flatGround': flatGround,
    };
  }

  @override
  String toString() {
    return 'Trick{id: $id, name: $name, level: $level, category: $category, flatGround: $flatGround}';
  }
}
