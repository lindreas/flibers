import 'dart:collection';
import 'dart:math';
import 'package:flibers/screens/about.dart';
import 'package:flibers/screens/game.dart';
import 'package:flibers/screens/players.dart';
import 'package:flibers/screens/quick_game.dart';
import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(FlibersApp());
}

class AppStyle {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20, fontFamily: "Droid Sans"),
      primary: const Color(0xffE47474),
      minimumSize: const Size(225, 35));
}

//if not used anywhere else, move to game?
class DropDownMenu extends StatelessWidget {
  String? page;
  String gameMode;
  DropDownMenu(this.gameMode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DropdownButtonHideUnderline(
            child: DropdownButton(
                isExpanded: true,
                iconSize: 50,
                iconEnabledColor: Color(0xffE47474),
                style: const TextStyle(fontSize: 20, fontFamily: "Droid Sans"),
                dropdownColor: const Color(0xffE47474),
                value: page,
                items: dropDownItem(),
                onChanged: (value) {
                  page = value as String;
                  switch (value) {
                    case "Start":
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      break;
                    case "New Game":
                      if (gameMode == "Quick Game") {
                        Navigator.popUntil(
                            context, ModalRoute.withName('QuickGame'));
                      }

                      if (gameMode == "Custom Game") {
                        Navigator.popUntil(
                            context, ModalRoute.withName('CustomGame'));
                      }

                      break;
                    case "About":
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            settings: const RouteSettings(name: "About"),
                            builder: (context) => const About()),
                      );
                      break;
                    default:
                  }
                }))
      ],
    );
  }

  List<DropdownMenuItem<String>> dropDownItem() {
    List<String> dropDownItems = ["Start", "New Game", "About"];
    return dropDownItems
        .map((value) => DropdownMenuItem(
              alignment: Alignment.centerRight,
              value: value,
              child: Text(value),
            ))
        .toList();
  }
  /*Container(
        width: 110,
        height: 400,
        child: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.

          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                decoration: BoxDecoration(
                  color: const Color(0xff194346),
                ),
                child: null,
              ),
              ListTile(
                title: const Text('Start'),
                onTap: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
              ListTile(
                title: const Text('New Game'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('QuickGame'));
                },
              ),
              ListTile(
                title: const Text('About'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        settings: const RouteSettings(name: "About"),
                        builder: (context) => const About()),
                  );
                },
              ),
            ],
          ),
        ));*/

}

class FlibersApp extends StatelessWidget {
  //final Logic logic;

  FlibersApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              const TextTheme(bodyText2: TextStyle(color: Color(0xffE47474)))),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
