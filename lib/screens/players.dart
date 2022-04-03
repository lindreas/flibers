import 'package:flibers/screens/custom_game.dart';

import 'game.dart';
import 'package:flutter/material.dart';
import 'start.dart';
import 'quick_game.dart';
import '../main.dart';

Map stats = {
  "player1": {"name": "", "score": [], "firstToGo": null},
  "player2": {"name": "", "score": [], "firstToGo": null}
};

createPlayers(String player, String name) {
  stats[player]["name"] = name;
  return stats;
}
/*
class ScreenArguments {
  //final Logic logic;
  final String gameMode;
  Map stats;
  ScreenArguments(this.stats, this.gameMode);
}*/

class Players extends StatelessWidget {
  //List tricks;
  //Players(this.tricks);
  //final Logic logic;

  String gameMode;

  Players(this.gameMode, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Player 1, enter your name:"),
            TextField(
              //obscureText: true,
              onSubmitted: (String value) async {
                Map stats = await createPlayers("player1", value);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      settings: const RouteSettings(name: "Players2"),
                      builder: (context) =>
                          Players2(gameMode, stats)), //tricks,
                );
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Player 1',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Players2 extends StatelessWidget {
  //List tricks;
  final String gameMode;
  Map stats;
  Players2(this.gameMode, this.stats, {Key? key})
      : super(key: key); //this.tricks,

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff194346),
      ),
      backgroundColor: const Color(0xff194346),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Player 2, enter your name:",
                style: TextStyle(
                  color: Color(0xffE47474),
                )),
            TextField(
              //obscureText: true,
              onSubmitted: (String value) async {
                Map stats = await createPlayers("player2", value);
                switch (gameMode) {
                  case "Quick Game":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(name: "QuickGame"),
                          builder: (context) =>
                              QuickGame(stats, gameMode)), //tricks,
                    );
                    break;
                  case "Custom Game":
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          settings: const RouteSettings(name: "CustomGame"),
                          builder: (context) =>
                              TrickSelection(stats, gameMode)), //tricks,
                    );
                    break;
                  default:
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Player 2',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
