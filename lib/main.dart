import 'package:flutter/material.dart';
import 'db.dart';
import 'screens/home.dart';

void main() {
  runApp(FlibersApp(new Logic()));
}

class Logic {
  List<String> tricks = [];
  void getTricks() async {
    final data = await SQLHelper.getItems();
    print(data);
  }

  getRandom(int level) async {
    final data = await SQLHelper.getRandom(level);
    tricks = [];
    for (var e in data) {
      tricks.add(e['name']);
    }
    return tricks;
  }

  Future<void> _addItem() async {
    //await SQLHelper.createItem("Switch Frontside 180", 3, "Ollie", 1);
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
  }

  // Tricks list here and called from here?
  void easy() {
    print("täällä 1");
  }

  void customGame() {
    print("täällä 2");
  }
}

class AppStyle {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontFamily: "Droid Sans"),
      primary: const Color(0xffE47474),
      minimumSize: const Size(225, 35));
}

class FlibersApp extends StatelessWidget {
  final Logic logic;

  FlibersApp(this.logic);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomePage(logic),
    );
  }
}
