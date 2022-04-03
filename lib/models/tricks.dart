import 'package:flutter/material.dart';
import 'db.dart';

class Tricks {
  List<String> tricks = [];

  Future<List<Map<String, dynamic>>> getTricks() async {
    final data = await SQLHelper.getItems();
    return data;
  }

  getRandom(String level) async {
    final data = await SQLHelper.getRandom(level);
    for (var e in data) {
      tricks.add(e['name']);
    }
    return tricks;
  }

  Future<void> addItem() async {
    //await SQLHelper.createItem("Fakie 360 Flip", 4, "Ollie", 1);
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
  }
}

class TrickModel {
  static Future<List<Map<String, dynamic>>> tricks = Tricks().getTricks();

  Trick getById(int id) => Trick(id);

  Trick getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Trick {
  final int id;

  Trick(this.id);

  @override
  int get hashCode => id;
}
