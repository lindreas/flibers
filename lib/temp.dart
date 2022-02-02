import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'flibers.db'),
    // When the database is first created, create a table to store tricks.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE tricks(id INTEGER PRIMARY KEY, name TEXT, category INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  // Define a function that inserts tricks into the database
  Future<void> insertTrick(Trick trick) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Trick into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same trick is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'tricks',
      trick.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the tricks from the tricks table.
  Future<List<Trick>> tricks() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The tricks.
    final List<Map<String, dynamic>> maps = await db.query('tricks');

    // Convert the List<Map<String, dynamic> into a List<Trick>.
    return List.generate(maps.length, (i) {
      return Trick(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
      );
    });
  }

  Future<void> updateTrick(Trick trick) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Trick.
    await db.update(
      'tricks',
      trick.toMap(),
      // Ensure that the Trick has a matching id.
      where: 'id = ?',
      // Pass the Trick's id as a whereArg to prevent SQL injection.
      whereArgs: [trick.id],
    );
  }

  Future<void> deleteTrick(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Trick from the database.
    await db.delete(
      'tricks',
      // Use a `where` clause to delete a specific trick.
      where: 'id = ?',
      // Pass the Trick's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Trick and add it to the tricks table
  var fido = Trick(
    id: 0,
    name: 'Ollie',
    category: 'Ollie',
  );

  await insertTrick(fido);

  // Now, use the method above to retrieve all the tricks.
  print(await tricks()); // Prints a list that include Fido.
  print("<------ 1");

  // Update Fido's category and save it to the database.
  fido = Trick(
    id: fido.id,
    name: fido.name,
    category: fido.category,
  );
  await updateTrick(fido);

  // Print the updated results.
  print(await tricks()); // Prints Fido with category 42.
  print("<------ 2");

  // Delete Fido from the database.
  await deleteTrick(fido.id);

  // Print the list of tricks (empty).
  print(await tricks());
  print("<------ 3");
}

class Trick {
  final int id;
  final String name;
  final String category;

  Trick({
    required this.id,
    required this.name,
    required this.category,
  });

  // Convert a Trick into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
    };
  }

  // Implement toString to make it easier to see information about
  // each trick when using the print statement.
  @override
  String toString() {
    return 'Trick{id: $id, name: $name, category: $category}';
  }
}
